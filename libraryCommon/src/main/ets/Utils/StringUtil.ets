export class StringUtil{

  static isEmpty(str? : string) : boolean{
    if(str == null){
      return true
    }else if(str?.trim().length == 0){
      return true
    }
    return false
  }

  static isNotEmpty(str? : string) : boolean{
    if(str == null || str == ""){
      return false
    }else if(str?.trim().length > 0){
      return true
    }
    return false
  }

  static replaceStr(str : string,p : string ,p1 : string = '') : string{
    str.replace(p,p1)
    return str
  }

}