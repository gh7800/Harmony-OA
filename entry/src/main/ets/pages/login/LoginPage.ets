import promptAction from '@ohos.promptAction'
import UserModel from '../../model/UserModel'
import LoadingDialog from '../../view/LoadingDialog'
import { UserManager } from '../../manager/UserManager'
import { LogUtils, RouterUtil, ToastUtil } from 'librarycommon'
import preferenceUtil from '../../utils/PreferencesUtil'
import loginViewModel from './LoginViewModel'
import { ConstantUtil } from '../../utils/ConstantUtil'

@Builder
export function LoginPageBuilder() {
  LoginPage()
}

@Component
struct LoginPage {
  @State message: string = '登 录'
  private username: string = ''
  private password: string = ''
  dialogController = new CustomDialogController({
    builder: LoadingDialog(),
    customStyle: true,
    cancel: () => {
      promptAction.showToast({ message: '已取消登录' })
    }
  })

  aboutToAppear() {
    preferenceUtil.getString(ConstantUtil.USERNAME).then(msg => {
      this.username = msg
      LogUtils.error(msg)
    })
  }

  build() {
    NavDestination() {
      Column() {
        Column() {
          Text(this.message)
            .fontColor($r('app.color.main'))
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 20 })

          TextInput({ placeholder: '请输入账号', text: this.username })
            .width('85%')
            .height(50)
            .type(InputType.Normal)
            .maxLength(11)
            .enterKeyType(EnterKeyType.Next)
            .onChange((value: string) => {
              this.username = value
            })

          TextInput({ placeholder: '请输入密码' })
            .width('85%')
            .height(50)
            .margin({ top: 10 })
            .type(InputType.Password)
            .maxLength(16)
            .enterKeyType(EnterKeyType.Send)
            .onChange((value: string) => {
              this.password = value
            })
            .onSubmit((keyType: EnterKeyType) => {
              if (keyType == EnterKeyType.Send) {
                this.login()
              }
            })

          Button($r('app.string.Submit'), { stateEffect: true, type: ButtonType.Capsule })//默认胶囊类型
            .backgroundColor($r('app.color.main'))
            .width('85%')
            .margin({ top: 20 })
            .onClick(() => {
              this.login()
            })
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)

      }
      .height("100%")
    }
    .hideTitleBar(true)
    .onReady(context => {

    })
    .onBackPressed(() => {
      RouterUtil.clearStack()
      RouterUtil.exitAPP(this)
      return true
    })

  }

  private login() {
    if (!this.username) {
      promptAction.showToast({ message: '账号不能为空' })
      return
    }

    if (!this.password) {
      promptAction.showToast({ message: '密码不能为空' })
      return
    }

    this.dialogController.open()
    loginViewModel.login(this.username, this.password)
      .then((response) => {
        if(response.success) {
          ToastUtil.show('登录成功')
          UserManager.saveUser(response.data as UserModel)
          RouterUtil.replace("MainPage")
        }else {
          ToastUtil.show(response.message)
        }
      })
      .finally(()=>{
        this.dialogController.close()
      })

  }
}
