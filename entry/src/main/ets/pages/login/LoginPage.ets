import promptAction from '@ohos.promptAction'
import api from '../../http/Api'
import UserModel from '../../model/UserModel'
import ApiResponse from '../../http/ApiRsponse'
import LoadingDialog from '../../view/LoadingDialog'
import userManager from '../../manager/UserManager'
import { RouterUtil, ToastUtil } from 'librarycommon'

@Component
export struct LoginPage {
  @State message: string = 'Login'
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

  }

  build() {
    NavDestination() {
      Column() {
        Column() {
          Text(this.message)
            .fontColor(Color.Orange)
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 20 })

          TextInput({ placeholder: '请输入账号' })
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
            .enterKeyType(EnterKeyType.Go)
            .onChange((value: string) => {
              this.password = value
            })
            .onSubmit((keyType: EnterKeyType) => {
              if (keyType == EnterKeyType.Done) {
                this.login()
              }
            })

          Button($r('app.string.Submit'), { stateEffect: true, type: ButtonType.Capsule })//默认胶囊类型
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

  }

  /**login*/
  private async login() {
    if (!this.username) {
      promptAction.showToast({ message: '账号不能为空' })
      return
    }

    if (!this.password) {
      promptAction.showToast({ message: '密码不能为空' })
      return
    }

    const params: LoginParams = {
      username: this.username,
      password: this.password
    }

    this.dialogController.open()

    const response: ApiResponse<UserModel> = await api.post('/auth/login', params)
    try {
      if (response.success) {
        this.dialogController.close()
        ToastUtil.show('登录成功')
        userManager.saveUser(response.data)
        //routerUtils.back()
        RouterUtil.pop()
      } else {
        this.dialogController.close()
        ToastUtil.show(response.message)
      }
    } catch (error) {
      this.dialogController.close()
      ToastUtil.show(error)
    }
    /*.then((response: ApiResponse<UserModel>) => {
      ToastUtil.show('登录成功')

      userManager.saveUser(response.data)

      setTimeout(() => {
        this.dialogController.close()
        //this.pathStack.replacePathByName("MainPage",null)
        //router.pushUrl({url : 'pages/MainPage'})
        RouterUtil.push("MainPage")
      }, 1000)

    })
    .catch((error: string) => {
      this.dialogController.close()
      ToastUtil.show(error)
    })*/

  }
}

@Builder
export function LoginPageBuilder() {
  LoginPage()
}


interface LoginParams {
  username: string,
  password: string,
}