import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import { AppGlobalContext } from '../utils/AppGlobalContext';
import preferenceUtil from '../utils/PreferencesUtil';
import { BusinessError } from '@kit.BasicServicesKit';
import { LogUtil, WindowUtil } from 'librarycommon'
import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import Want from '@ohos.app.ability.Want';
import constantUtil from '../utils/ConstantUtil';

export default class EntryAbility extends UIAbility {

  //1、应用初始化
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    console.error("onCreate")
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  //1、1 窗口回调
  onWindowStageCreate(windowStage: window.WindowStage) {
    console.error("onWindowStageCreate")
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    preferenceUtil.getPreferences(this.context)
    AppGlobalContext.getContext().setValue('context',this.context.getApplicationContext())


    let dir = this.context.filesDir
    LogUtil.error(dir)

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });

    windowStage.getMainWindow((err : BusinessError,data) => {
      let windowClass = data
      windowClass.setWindowSystemBarProperties({statusBarColor:'#00B785'})

      // WindowUtil.listenToAppStorage(windowClass)
      // WindowUtil.setDarkEnable(windowClass,false)

      let uiContext = windowClass.getUIContext()
      let uiObserver = uiContext.getUIObserver()

      uiObserver.on("navDestinationUpdate",(info)=>{
        if(info.state == 0){ // 组件显示
          LogUtil.errorAny("显示组件————"+info.name)
        }else if(info.state == 1){ //组件隐藏
          LogUtil.errorAny("隐藏组件————"+info.name)
        }else {
          //LogUtil.errorAny(info.state+"________________"+info.name)
        }
      })
    })
  }

  //2、在前台
  onForeground() {
    console.error("onForeground")
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  //3、页面不可见
  onBackground() {
    console.error("onBackground")
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }

  onWindowStageDestroy() {
    console.error("onWindowStageDestroy")
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  //4、销毁
  onDestroy() {
    console.error("onDestroy")
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }
}
