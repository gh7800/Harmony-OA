import UserModel from '../model/UserModel'
import { ConstantUtil } from '../utils/ConstantUtil'
import { AppGlobalContext } from '../utils/AppGlobalContext'
import preferenceUtil from '../utils/PreferencesUtil'

/**
 * user管理
 */
export class UserManager {
  static saveUser(userModel: UserModel) {
    preferenceUtil.save(ConstantUtil.USERNAME, userModel.username)
    preferenceUtil.save(ConstantUtil.REAL_NAME, userModel.realname)
    preferenceUtil.save(ConstantUtil.COMPANY_UUID, userModel.company_uuid)
    preferenceUtil.save(ConstantUtil.USER_UUID, userModel.uuid)
    preferenceUtil.save(ConstantUtil.TOKEN, userModel.token)
    AppGlobalContext.getContext().setValue(ConstantUtil.TOKEN, userModel.token)
  }

  //总公司
  static isParentCompany(): boolean {
    let result = false
    let str = preferenceUtil.getStringSync(ConstantUtil.COMPANY_UUID)
    if (str == "XCHW") {
      result = true
    } else {
      result = false
    }
    return result
  }

  static isXingBan(): boolean {
    let result = false
    let str = preferenceUtil.getStringSync(ConstantUtil.USERNAME)
    if (str.startsWith("0002")) {
      result = true
    } else {
      result = false
    }
    return result
  }

}