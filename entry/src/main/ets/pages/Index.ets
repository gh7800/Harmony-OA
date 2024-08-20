import preferenceUtil from '../utils/PreferencesUtil'
import constantUtil from '../utils/ConstantUtil'
import toastUtil from '../utils/ToastUtil'
import { AppGlobalContext } from '../utils/AppGlobalContext'
// import { LoginPageBuilder } from './login/LoginPage'
// import { MainPageBuilder } from './MainPage'
import router from '@ohos.router'

/**
 * 输入page快速创建页面
 * 闪屏页 -- 最先显示
 */
@Entry
@Component
struct Index {
  pathStack: NavPathStack = new NavPathStack()

  /*@Builder
  PagesMap(name: string) {
    if (name == 'LoginPage') {
      LoginPageBuilder()
    }else if(name == 'LoginPage'){
      MainPageBuilder()
    }
  }*/

  aboutToAppear() {
    AppStorage.setOrCreate(constantUtil.PATH_STACK, this.pathStack)
    preferenceUtil.getPreferences(getContext())

    setTimeout(() => {
      let url = 'pages/login/LoginPage'

      preferenceUtil.getString(constantUtil.TOKEN)
        .then((data) => {
          if (data) {
            AppGlobalContext.getContext().setValue(constantUtil.TOKEN, data)
            url = 'pages/MainPage'
          }
        })
        .catch((err: string) => {
          toastUtil.show(err)
        })
        .finally(() => {
          this.startPage(url)
        })

    }, 1000)
  }

  build() {
    //Navigation(this.pathStack) {
      Row() {
        Column(
          {
            space: 10, //组件之间的间距
          }
        ) {

          Image($r('app.media.icon'))
            .width(100)
            .height(100)

          Text("鸿蒙OS")
            .fontSize(22)
            .margin({ top: 10 })
            .fontWeight(FontWeight.Bold)

          Button('移动办公', { type: ButtonType.Normal, stateEffect: true })
            .borderRadius(20)
            .margin({ top: 30 })
            .width(150)
            .onClick(() => {

            })
        }
        .width('100%')
        .padding(22)
      }

      .height('100%')
      .alignItems(VerticalAlign.Bottom)
      .padding({ bottom: 100 })
    }
    //.mode(NavigationMode.Stack)
    //.navDestination(this.PagesMap)
  //}

  startPage(url: string) {
    //this.pathStack.replacePathByName(url,null)
    router.pushUrl({url})
  }
}