import promptAction from '@ohos.promptAction'
import { TitleBarComponent } from '../../view/TitleBarComponent'
import { LogUtils, RouterUtil, ToastUtil } from 'librarycommon'
import { AppGlobalContext } from '../../utils/AppGlobalContext'
import preferenceUtil from '../../utils/PreferencesUtil'
import constantUtil from '../../utils/ConstantUtil'

@Builder
export function SettingPageBuilder() {
  SettingPage()
}

@Component
struct SettingPage {
  @State title: string = '设置'

  build() {
    NavDestination() {
      Column() {
        TitleBarComponent({title: this.title})

        Column() {

        }
        .layoutWeight(1)

        Button('退出应用程序')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .border({ radius: 40 })
          .backgroundColor($r('app.color.black'))
          .width('90%')
          .height(40)
          .fontColor($r('app.color.write'))
          .onClick(() => {
            promptAction.showDialog({
              title: '提示',
              message: '您确定退出当前账号?',
              buttons: [
                { text: '取消', color: '#ffd44848' },
                { text: '确定', color: '#000000' }
              ]
            })
              .then(data => {
                if (data.index == 0) {
                  ToastUtil.show('取消')
                } else {
                  preferenceUtil.clear()
                  // AppGlobalContext.getContext().clear()

                  preferenceUtil.getString(constantUtil.USERNAME).then(msg=>{
                    LogUtils.error("username----"+msg)
                  })

                  RouterUtil.clearStack()
                  RouterUtil.push('LoginPage')
                }
              })
          })

      }
      .width('100%')
      .height('100%')
    }
    .hideTitleBar(true)
    //.title("设置",{backgroundColor:$r('app.color.main')})

  }
}