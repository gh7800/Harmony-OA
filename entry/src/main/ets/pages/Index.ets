import preferenceUtil from '../utils/PreferencesUtil'
import { MainPage } from './MainPage'
import { SplashPage } from './SplashPage'
import { LogUtil, RouterUtil, StringUtil } from 'librarycommon'
import constantUtil from '../utils/ConstantUtil'
import { AppGlobalContext } from '../utils/AppGlobalContext'
import { LoginPage } from './login/LoginPage'

/**
 * 最先显示进入
 */
@Preview
@Entry
@Component
struct Index {
  @State @Watch("onSplashPageFinish") isSplash: boolean = true
  @State isLogin: boolean = false

  onSplashPageFinish() {
    //启动页结束后进行操作，如请求网络等
    LogUtil.error(this.isSplash)
  }

  aboutToAppear() {
    preferenceUtil.getString(constantUtil.TOKEN)
      .then((value: string) => {
        AppGlobalContext.getContext().setValue(constantUtil.TOKEN, value)
        if (StringUtil.isNotEmpty(value)) {
          this.isLogin = true
        }
      })

  }

  build() {
    Navigation(RouterUtil.navPathStack) {
      Column() {
        if (this.isSplash) {
          SplashPage({ isSplash: this.isSplash })
        } else if (!this.isLogin) {
          LoginPage()
        } else {
          MainPage()
        }
      }
    }
    .height('100%')
    .hideTitleBar(true)
    .systemBarStyle({statusBarContentColor:'#FFFFFF'})
    .toolbarConfiguration(null,{backgroundColor:$r('app.color.write')})
  }
}