import hilog from '@ohos.hilog'
import { LogUtil } from '@pura/harmony-utils';
import { BusinessError } from '@ohos.base';

/**
 * 打印日志
 * debug中查看，OATag
 */
export class LogUtils {
  static TAG: string | undefined = "OATag";

  static error(msg: string | number | boolean | undefined) {
    let str = msg + ''
    //hilog.error(0x0000, LogUtils.TAG, '%{public}s', str);
    LogUtil.debug(str)
  }

   static errorAny(msg : object | string | Array<object>){
    //hilog.debug(0x0000, LogUtils.TAG, '%{public}s', msg);
     if(msg as string) {
       LogUtil.debug(msg as string)
     }else if(msg as Array<object>){
       LogUtil.debug(msg.toString())
     }else {
       LogUtil.print(msg)
     }
  }

  /**
   * 打印json
   */
   static errorJson(obj : object){
    try {
      if (typeof obj === 'object') {
        let str = JSON.stringify(obj, null, 2)
        let arr: string[] = str.split('\n')
        for (let index = 0; index < arr.length; index++) {
          console.debug(arr[index])
        }
      } else {
        obj = JSON.parse(obj)
        let str = JSON.stringify(obj, null, 2)
        let arr = str.split('\n')
        for (let index = 0; index < arr.length; index++) {
          console.debug(arr[index])
        }
      }
    } catch (err) {
      let error = err as BusinessError; //异常了，说明不是JSON字符串
      LogUtil.debug(`LogUtil-print-异常 ~ code: ${error.code} -·- message: ${error.message}`);
    }
  }
}

