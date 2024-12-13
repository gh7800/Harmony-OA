import preferenceUtil from '../utils/PreferencesUtil'
import { SplashPage } from './SplashPage'
import { LogUtils, RouterUtil, StringUtil, TimeUtil } from 'librarycommon'
import { AppGlobalContext } from '../utils/AppGlobalContext'
import { ConstantUtil } from '../utils/ConstantUtil'

// import { MainPage } from './MainPage'
// import { LoginPage } from './login/LoginPage'


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
    LogUtils.error("启动结束")
  }

  aboutToAppear() {
    LogUtils.error(TimeUtil.formatTimestamp(TimeUtil.getCurrentTimestamp(),"YYYY-MM-DD"))
    preferenceUtil.getPreferences(getContext())

    preferenceUtil.getString(ConstantUtil.TOKEN)
      .then((value: string) => {
        AppGlobalContext.getContext().setValue(ConstantUtil.TOKEN, value)
        if (StringUtil.isNotEmpty(value)) {
          this.isLogin = true
        }
      })
  }

  onPageShow(): void {
    LogUtils.error("onPageShow")
  }

  build() {
    Navigation(RouterUtil.navPathStack) {
      Column() {
        SplashPage()
        /*if (this.isSplash) {
          SplashPage({ isSplash: this.isSplash })
        } else if (!this.isLogin) {
          LoginPage()
        } else {
          MainPage()
        }*/
      }
    }
    .height('100%')
    .hideTitleBar(true)
    .systemBarStyle({statusBarContentColor:'#FFFFFF'})
    .toolbarConfiguration(null,{backgroundColor:$r('app.color.write')})
  }
}