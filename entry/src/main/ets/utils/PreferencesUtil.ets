import Preferences from '@ohos.data.preferences'
import { LogUtils } from 'librarycommon'
import { Context } from '@kit.AbilityKit'

/**
 * K-V 首选项
 * 异步函数
 */

class PreferenceUtil {
  private preferencesName: string = "HYLD_OA"
  private preferenceInstance: Preferences.Preferences

  constructor() {
    this.preferenceInstance = {} as Preferences.Preferences
  }

  getPreferences(context: Context) {
    let promise = Preferences.getPreferences(context, this.preferencesName)
    promise.then((object) => {
      this.preferenceInstance = object
      LogUtils.error('获取实例成功_' + object)
    }).catch((err: string) => {
      LogUtils.error('实例获取失败__err' + err)
    })
  }

  save(key: string, value: string) {
    if (!this.preferenceInstance) {
      throw new Error('preferenceInstance__' + this.preferenceInstance)
      return
    }
    this.preferenceInstance.put(key, value, (err) => {
      if (err) {
        console.error('保存失败_err', err)
      } else {
        console.error('保存成功-' + value)
      }
    })

    this.preferenceInstance.flush() //数据量大时使用，避免保存失败
  }

  getString(key: string, def: string = "") {
    return this.preferenceInstance.get(key, def) as Promise<string>
  }

  getStringSync(key: string, def: string = "") : string{
    return this.preferenceInstance.getSync(key, def) as string
  }

  async getNumber(key: string, def: number = 0) {
    return this.preferenceInstance.get(key, def) as Promise<number>
  }

  async getBoolean(key: string, bl: boolean = false) {
    return this.preferenceInstance.get(key, bl) as Promise<boolean>
  }

  //删除key
  async deleteKey(key: string) {
    return this.preferenceInstance.delete(key)
  }

  //清空所有
  clear() {
    this.preferenceInstance.clear()
    this.preferenceInstance.flush()

    LogUtils.error("全部删除")
  }
}

const preferenceUtil = new PreferenceUtil()

export default preferenceUtil