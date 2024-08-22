import hilog from '@ohos.hilog'
import {StringUtil} from './StringUtil'

export class LogUtil {

  static error(msg: string | number | boolean) {
    let str = msg + ''
    str = StringUtil.replaceStr(str,'/','-')
    //console.error(str)
    hilog.error(0x0000, 'Tag', '%{public}s', str);
    //console.error(msg.toString())
  }

  static errorAny(msg : string | number | boolean | object){
    // console.error(msg)
    hilog.error(0x0000, 'Tag', '%{public}s', msg);
  }

  static errorJson(json : object){
    //console.error(JSON.stringify(tag))
    hilog.error(0x0000, 'JSON', '%{public}s', JSON.stringify(json) ?? '');
  }

  static info(tag : string,msg : string){
    hilog.error(0x0000, tag, '%{public}s', msg);
  }

}

