import router from '@ohos.router'
import preferenceUtil from '../utils/PreferencesUtil'
import constantUtil from '../utils/ConstantUtil'
import toastUtil from '../utils/ToastUtil'
import { AppGlobalContext } from '../utils/AppGlobalContext'
import { LoginPageBuilder } from './LoginPage'
import { MainPageBuilder } from './MainPage'

/**
 * 输入page快速创建页面
 * 闪屏页 -- 最先显示
 */
@Entry
@Component
struct Index {
  pathStack: NavPathStack = new NavPathStack()

  @Builder
  PagesMap(name: string) {
    if (name == 'LoginPage') {
      LoginPageBuilder()
    }else if(name == 'MainPage'){
      MainPageBuilder()
    }
  }

  aboutToAppear() {
    AppStorage.setOrCreate(constantUtil.PATH_STACK, this.pathStack)
    preferenceUtil.getPreferences(getContext())

    setTimeout(() => {
      let url = 'LoginPage'

      preferenceUtil.getString(constantUtil.TOKEN)
        .then((data) => {
          if (data) {
            AppGlobalContext.getContext().setValue(constantUtil.TOKEN, data)
            url = 'MainPage'
          }
        })
        .catch((err: string) => {
          toastUtil.show(err)
        })
        .finally(() => {
          this.startPage(url)
        })

    }, 1500)
  }

  build() {
    Navigation(this.pathStack) {
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
              this.pathStack.pushPathByName('LoginPage',null)
            })
        }
        .width('100%')
        .padding(22)
      }

      .height('100%')
      .alignItems(VerticalAlign.Bottom)
      .padding({ bottom: 100 })
    }
    .mode(NavigationMode.Stack)
    .navDestination(this.PagesMap)
  }

  startPage(url: string) {
    this.pathStack.pushPathByName(url,null)
    /* router.replaceUrl({ url }, router.RouterMode.Single, (err) => { //关闭当前页并打开新的页面
       console.error(err.message)
     })*/
  }
}