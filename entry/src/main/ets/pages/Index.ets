import preferenceUtil from '../utils/PreferencesUtil'
import constantUtil from '../utils/ConstantUtil'
import toastUtil from '../utils/ToastUtil'
import { AppGlobalContext } from '../utils/AppGlobalContext'
// import { LoginPageBuilder } from './login/LoginPage'
// import { MainPageBuilder } from './MainPage'
import router from '@ohos.router'
import { LoginPage } from './login/LoginPage'
import { MainPage } from './MainPage'
import { SplashPage } from './SplashPage'
import logUtil from '../utils/LogUtil'
import { RouterUtil } from '../utils/RouterUtil'

/**
 * 输入page快速创建页面
 * 闪屏页 -- 最先显示
 */
@Preview
@Entry
@Component
struct Index {
  @Provide("pathStack") pathStack: NavPathStack = new NavPathStack()
  @State @Watch("onSplashPageFinish") isSplash : boolean = true

  onSplashPageFinish() {
    //启动页结束后进行操作，如请求网络等
    getContext()
  }

  @Builder
  PagesMap(name: string) {
    if (name == 'LoginPage') {
      LoginPage()
    } else if (name == 'MainPage') {
      MainPage()
    } else {
      SplashPage({isSplash:this.isSplash})
    }
  }

  aboutToAppear() {
    AppStorage.setOrCreate(constantUtil.PATH_STACK, this.pathStack)
    preferenceUtil.getPreferences(getContext())

    /*setTimeout(() => {
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

    }, 1000)*/
  }

  build() {
    Stack() {
      Navigation(RouterUtil.navPathStack) {
        Column() {
          //this.PagesMap(this.name)
          if(this.isSplash){
            SplashPage({isSplash: this.isSplash})
          }else {
            MainPage()
          }
        }
      }

      .height('100%')
      .hideTitleBar(true)
      .navBarWidth('50%')
      // .navDestination(this.pageMap)
      .mode(NavigationMode.Stack)

      // .hideNavBar(false)
      // .toolbarConfiguration(this.tabBuilder)
    }
    .alignContent(Alignment.BottomEnd)
    .height('100%')
    .backgroundColor("#F5F5F5")
    }


  //.mode(NavigationMode.Stack)
  //}

  startPage(url: string) {
    this.pathStack.pushPathByName(url, null,(info)=>{
      logUtil.error(info.result.toString())
      this.startPage(info.result.toString())
    },true)
    //router.pushUrl({ url })
  }
}