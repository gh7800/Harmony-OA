import promptAction from '@ohos.promptAction'
import { LogUtils } from './LogUtils'

export class ToastUtil {
  static show(msg: string | number | boolean | null,duration : number = 1500) {
    if(msg as null){
      LogUtils.error("null type")
    }else {
      promptAction.showToast({ message: msg + '' ,duration})
    }
  }
}
