import { LogUtil } from './LogUtil';

const TAG = 'RouterUtil';

export  class RouterUtil {
  static navPathStack: NavPathStack = new NavPathStack();
  static routerStack: Array<string> = new Array();

  public static push(name: string, param: object | undefined = undefined, callback: Callback<PopInfo> | undefined = undefined) {
    RouterUtil.routerStack.push(name);
    RouterUtil.navPathStack.pushPathByName(name, param, callback, true)

    RouterUtil.printStack()
  }

  public static replace(name: string, param: object | undefined = undefined) {
    RouterUtil.routerStack.pop();
    RouterUtil.routerStack.push(name);
    RouterUtil.navPathStack.replacePathByName(name, param, true)
  }

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

  public static popHome() {
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
    LogUtil.errorJson(pathNameList)
  }
}
