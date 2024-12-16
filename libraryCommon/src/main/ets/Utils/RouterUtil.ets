import { LogUtils } from './LogUtils';
import { common } from '@kit.AbilityKit';

/**
 * 跳转路由
 */
export  class RouterUtil {
  static navPathStack: NavPathStack = new NavPathStack();
  static routerStack: Array<string> = new Array();

  /**
   * 跳转页面
   * @param name
   * @param param 传参
   * @param callback 返回结果,let str = callback.result as string
   */
  public static push(name: string, param: string | boolean | number | object | null = null, callback: Callback<PopInfo> | undefined = undefined) {
    RouterUtil.routerStack.push(name);
    RouterUtil.navPathStack.pushPathByName(name, param, callback, true)

    RouterUtil.printStack()
  }

  /**
   * 替换页面
   * @param name
   * @param param
   */
  public static replace(name: string, param: object | undefined = undefined) {
    RouterUtil.routerStack.pop();
    RouterUtil.routerStack.push(name);
    RouterUtil.navPathStack.replacePathByName(name, param, true)
  }

  /**
   * 返回上一页
   * @param result
   */
  public static pop(result?: Object) {
    if (result !== undefined) {
      RouterUtil.navPathStack.pop(result, true)
    } else {
      RouterUtil.navPathStack.pop(true)
    }
  }

  public static finishPage(name: string) {
    RouterUtil.navPathStack.removeByName(name)
  }

  /**
   * 清空栈
   */
  public static clearStack() {
    RouterUtil.routerStack.length = 0;
    RouterUtil.navPathStack.clear()
  }

  public static size() {
    return RouterUtil.navPathStack.size()
  }

  /**
   * 打印堆栈
   */
  public static printStack(){
    const pathNameList = RouterUtil.navPathStack.getAllPathName()
    LogUtils.errorJson(pathNameList)
  }

  /**
   * 退出app
   */
  static exitAPP(component?: Object){
    let context = getContext(component) as common.UIAbilityContext;
    context.terminateSelf()
  }
}
