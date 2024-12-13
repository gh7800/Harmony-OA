const daysOfWeek = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];

/**
 * 日期-日历-时间 工具
 */
export class TimeUtil{
  /**
   * 获取当前时间的时间戳（毫秒）
   */
  static getCurrentTimestamp(): number {
    return new Date().getTime();
  }

  /**
   * 日期转时间戳
   */
  static getDateForNum(time : string) : number{
    const date = new Date(time);
    return date.getTime()
  }

  /**
   * 将时间戳转换为指定格式的日期字符串
   */
   static getDate(timestamp: number, format: string = 'YYYY-MM-DD HH:mm:ss'): string {
    const date = new Date(timestamp);
    const year = date.getFullYear();
    const month = TimeUtil.padZero(date.getMonth() + 1); // 月份从0开始，需加1
    const day = TimeUtil.padZero(date.getDate());
    const hours = TimeUtil.padZero(date.getHours());
    const minutes = TimeUtil.padZero(date.getMinutes());
    const seconds = TimeUtil.padZero(date.getSeconds());

    return format.replace('YYYY', year.toString())
      .replace('MM', month)
      .replace('DD', day)
      .replace('HH', hours)
      .replace('mm', minutes)
      .replace('ss', seconds);
  }

  // 辅助方法：数字补零操作，保证日期格式的每个部分为两位数
   static padZero(value: number): string {
    return value < 10 ? '0' + value : value.toString();
  }

  /**
   * 星期几
   */
  static getWeek(time: string | number = this.getCurrentTimestamp()): string{
    let date = new Date(time)
    let day = date.getDay()
    return daysOfWeek[day]
  }

}