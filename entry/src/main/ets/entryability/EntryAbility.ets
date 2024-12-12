import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import { AppGlobalContext } from '../utils/AppGlobalContext';
import preferenceUtil from '../utils/PreferencesUtil';
import { BusinessError } from '@kit.BasicServicesKit';
import { LogUtils, WindowUtil } from 'librarycommon'
import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import Want from '@ohos.app.ability.Want';
import { AppUtil, LogUtil } from '@pura/harmony-utils';
import { bundleManager } from '@kit.AbilityKit';

export default class EntryAbility extends UIAbility {
  private isRelease = false;

  //1、应用初始化
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    console.error("onCreate")
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');

    bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION).then((data) => {
      let type = data.appInfo.appProvisionType //获取当前环境
      if (type == "debug") {
        this.isRelease = true;
      } else {
        this.isRelease = false;
      }
      LogUtil.init(1, LogUtils.TAG, this.isRelease)
    })

    AppUtil.init(this.context)
  }

  //1、1 窗口回调
  onWindowStageCreate(windowStage: window.WindowStage) {
    console.error("onWindowStageCreate")
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    preferenceUtil.getPreferences(this.context)
    AppGlobalContext.getContext().setValue('context', this.context.getApplicationContext())


    let dir = this.context.filesDir
    LogUtils.error(dir)

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });

    windowStage.getMainWindow((err: BusinessError, data) => {
      try {
        let windowClass = data
        windowClass.setWindowSystemBarProperties({
          statusBarColor: '#00B785'
        })

        // WindowUtil.listenToAppStorage(windowClass)
        // WindowUtil.setDarkEnable(windowClass,false)

        let uiContext = windowClass.getUIContext()
        let uiObserver = uiContext.getUIObserver()

        uiObserver.on("navDestinationUpdate", (info) => {
          if (info.state == 0) { // 组件显示
            LogUtils.error("显示组件————" + info.name)
          } else if (info.state == 1) { //组件隐藏
            LogUtils.error("隐藏组件————" + info.name)
          } else {
            //LogUtils.errorAny(info.state+"________________"+info.name)
          }
        })

      } catch (error) {
        if (error as BusinessError) {
          LogUtils.error(error.message)
        }
      }
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
