export class TimeUtil{
  // 获取当前时间的时间戳（毫秒）
  static getCurrentTimestamp(): number {
    return new Date().getTime();
  }

  // 将时间戳转换为指定格式的日期字符串
   static formatTimestamp(timestamp: number, format: string = 'YYYY-MM-DD HH:mm:ss'): string {
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
}