const TAG = 'RouterUtil';

export  class RouterUtil {
  // static navPathStack: NavPathStack = new NavPathStack();
  private routerStack: Array<string> = new Array();

  private static instance : RouterUtil
  navPathStack: NavPathStack = new NavPathStack()

  public static getInstance() : RouterUtil{
    if(!RouterUtil.instance){
      RouterUtil.instance = new RouterUtil()
    }
    return RouterUtil.instance
  }

  public setNavPathStack(pathStack : NavPathStack){
    this.navPathStack = pathStack
  }

  public push(name: string, parm: object | undefined = undefined, callback: Callback<PopInfo> | undefined = undefined) {
    this.routerStack.push(name);
    this.navPathStack.pushPathByName(name, parm, callback, true)
  }

  public replace(name: string, parm: object | undefined = undefined) {
    this.routerStack.pop();
    this.routerStack.push(name);
    this.navPathStack.replacePathByName(name, parm, true)
  }

  public pop(result?: Object) {
    if (result !== undefined) {
      this.navPathStack.pop(result, true)
    } else {
      this.navPathStack.pop(true)
    }
  }

  public finishPage(name: string) {
    this.navPathStack.removeByName(name)
  }

  public popHome() {
    this.routerStack.length = 0;
    this.navPathStack.clear()
  }

  public size() {
    return this.navPathStack.size()
  }
}
