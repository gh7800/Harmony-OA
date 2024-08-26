import preferenceUtil from '../utils/PreferencesUtil'
import { MainPage } from './MainPage'
import { SplashPage } from './SplashPage'
import { LogUtil, RouterUtil } from 'librarycommon'
import constantUtil from '../utils/ConstantUtil'
import { AppGlobalContext } from '../utils/AppGlobalContext'

/**
 * 最先显示进入
 */
@Preview
@Entry
@Component
struct Index {
  @State @Watch("onSplashPageFinish") isSplash : boolean = true

  onSplashPageFinish() {
    //启动页结束后进行操作，如请求网络等
    LogUtil.error(this.isSplash)
  }

  aboutToAppear() {
    //preferenceUtil.getPreferences(getContext())
    preferenceUtil.getString(constantUtil.TOKEN)
      .then((value : string)=>{
        AppGlobalContext.getContext().setValue(constantUtil.TOKEN,value)
      })

  }

  build() {
      Navigation(RouterUtil.navPathStack) {
        Column() {
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
    }

}