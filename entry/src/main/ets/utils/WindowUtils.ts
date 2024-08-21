/*
 * @Desc: 窗口工具管理相关
 * @Author: qincji
 * @Date: 2024/7/1
 */
import { display, window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import logUtil from './LogUtil';

const TAG = 'WindowUtil';

export class WindowUtil {
  /**
   * 监听状态栏、底部导航栏、屏幕宽高的变化，并且使用AppStorage进行发送，只需要在需要处理页面内接收
   * @StorageProp('statusHeight') statusHeight: number = 0; //状态栏高度（单位：vp）
   * @StorageProp('bottomHeight') bottomHeight: number = 0; //导航栏高度（单位：vp）
   * @StorageProp('screenHeight') screenHeight: number = 0; //屏幕高度（单位：vp）
   * @StorageProp('screenWidth') screenWidth: number = 0; //屏幕宽度（单位：vp）
   * @param windowClass
   */
  static listenToAppStorage(windowClass: window.Window) {
    try {
      windowClass.on('avoidAreaChange', (data) => {
        logUtil.error(TAG + "__" + 'avoidAreaChange发生变化：' + JSON.stringify(data.type) + ', area: ' + JSON.stringify(data.area))

        // 获取系统状态栏和导航栏高度
        window.getLastWindow(getContext()).then((lastWindow) => {
          let areas = lastWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM); //以状态栏为避让
          const statusHeight = px2vp(areas.topRect.height);

          areas = lastWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR); // 以导航条避让
          const bottomHeight = px2vp(areas.bottomRect.height);

          logUtil.error(TAG + "__" + `获取系统状态栏和导航栏高度: ${statusHeight} | ${bottomHeight}`)
          AppStorage.setOrCreate('statusHeight', statusHeight);
          AppStorage.setOrCreate('bottomHeight', bottomHeight);

          let displayClass: display.Display = display.getDefaultDisplaySync();
          let screenHeight = px2vp(displayClass.height);
          let screenWidth = px2vp(displayClass.width);

          logUtil.error(TAG + "__" + `获取系统屏幕高度和屏幕宽度: ${screenHeight} | ${screenWidth}`)
          AppStorage.setOrCreate('screenHeight', screenHeight);
          AppStorage.setOrCreate('screenWidth', screenWidth);
        });

      });
    } catch (exception) {
      logUtil.error(TAG + "__" +  `avoidAreaChange监听失败. Cause code: ${exception.code}, message: ${exception.message}`)
    }
  }


  /**
   * 设置状态栏和导航栏的暗黑模式
   * @param windowClass
   * @param isDark
   */
  static setDartEnable(windowClass: window.Window, isDark: boolean = false) {
    let sysBarProps: window.SystemBarProperties = {
      //状态栏
      statusBarColor: '#00FFFFFF', //设置透明颜色
      statusBarContentColor: isDark ? '#000000' : '#FFFFFF',

      //导航栏
      navigationBarColor: '#00FFFFFF', //设置透明颜色
      navigationBarContentColor: isDark ? '#000000' : '#FFFFFF',
    };
    WindowUtil.setBarColor(windowClass, sysBarProps);
  }


  /**
   * 显示并设置系统的状态栏和导航栏内容和背景颜色
   * @param windowClass
   * @param sysBarProps
   */
  static setBarColor(windowClass: window.Window, sysBarProps: window.SystemBarProperties) {
    try {
      WindowUtil.setBarEnable(windowClass);
      windowClass.setWindowLayoutFullScreen(true, undefined);
      windowClass.setWindowSystemBarProperties(sysBarProps, undefined)
    } catch (err) {
    }
  }

  /**
   * 隐藏系统的状态栏和导航栏来实现全屏
   * @param windowClass
   */
  static setFullScreenHideBar(windowClass: window.Window) {
    WindowUtil.setBarEnable(windowClass, []);
  }

  /**
   * 显示或隐藏系统的状态栏和导航栏，默认都显示
   * @param windowClass
   * @param names
   */
  static setBarEnable(windowClass: window.Window, names: Array<'status' | 'navigation'> = ['status', 'navigation']) {
    windowClass.setWindowSystemBarEnable(names, (err: BusinessError) => {
      let errCode: number = err.code;
      if (errCode) {
        logUtil.error(TAG + "__" + 'Failed to set the system bar to be visible. Cause:' + JSON.stringify(err))
        return;
      }
      logUtil.error(TAG + "__" + 'Succeeded in setting the system bar to be visible.');
    });
  }
}
