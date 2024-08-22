export default class UserModel{
  username : string
  uuid : string
  realname : string
  mobile : string
  company_uuid : string
  department_uuid : string
  avatar : string
  token : string

  constructor(username: string, uuid: string, realname: string, mobile: string, company_uuid: string,
    department_uuid: string, avatar: string, token: string) {
    this.username = username
    this.uuid = uuid
    this.realname = realname
    this.mobile = mobile
    this.company_uuid = company_uuid
    this.department_uuid = department_uuid
    this.avatar = avatar
    this.token = token
  }


}
