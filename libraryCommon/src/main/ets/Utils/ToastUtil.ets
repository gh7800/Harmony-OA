import promptAction from '@ohos.promptAction'

export class ToastUtil {
  static show(msg: string | number | boolean,duration : number = 1500) {
    promptAction.showToast({ message: msg + '' ,duration})
  }
}
