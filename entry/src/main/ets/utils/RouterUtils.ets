import router from '@ohos.router'
import { LogUtil } from 'librarycommon'

class RouterUtils{

  //添加路由页面
  pushUrl(options: router.RouterOptions,mode = router.RouterMode.Standard){
    router.pushUrl({url: options.url,params: options.params},mode,(error)=>{
      LogUtil.error(error.message)
    })
  }

  //替换路由页面
  replaceUrl(options: router.RouterOptions,mode = router.RouterMode.Standard){
    router.replaceUrl({url: options.url,params: options.params},mode,(error)=>{
      LogUtil.error(error.message)
    })
  }

  back(){
    router.back()
  }

  clearStackS(){
    router.clear()
  }

}

const routerUtils = new RouterUtils()
export default routerUtils