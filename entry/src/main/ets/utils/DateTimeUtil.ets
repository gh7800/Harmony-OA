
/**
 * @file 日期工具
 */
import { DateUtil } from "@pura/harmony-utils";

const NINE: number = 9; // 这是数字9

export class DateTimeUtil {
  /**
   * 时分秒
   */
  static getTime(): string {
    const DATETIME = new Date();
    return DateTimeUtil.concatTime(
      DATETIME.getHours(),
      DATETIME.getMinutes(),
      DATETIME.getSeconds()
    );
  }

  /**
   * 年月日
   */
  static getDate(): string {
    const DATETIME = new Date();
    return DateTimeUtil.concatDate(
      DATETIME.getFullYear(),
      DATETIME.getMonth() + 1,
      DATETIME.getDate()
    );
  }

  /**
   * 日期不足两位补充0
   * @param value-数据值
   */
  static fill(value: number): string {
    return (value > NINE ? '' : '0') + value;
  }

  /**
   * 年月日格式修饰
   * @param year
   * @param month
   * @param date
   */
  static concatDate(year: number, month: number, date: number): string {
    return `${year}-${DateTimeUtil.fill(month)}-${DateTimeUtil.fill(date)}`;
  }

  /**
   * 时分秒格式修饰
   * @param hours
   * @param minutes
   * @param seconds
   */
  static concatTime(hours: number, minutes: number, seconds: number): string {
    return `${DateTimeUtil.fill(hours)}:${DateTimeUtil.fill(minutes)}:${DateTimeUtil.fill(seconds)}`;
  }

  /**
   * 星期几
   */
  static getWeek(date : string): string{
    let week = ""
    let num = DateUtil.getWeekDay(date)
    if(num == 0){
      week = "星期日"
    }else if(num == 1){
      week = "星期一"
    }else if(num == 6){
      week = "星期六"
    }else if(num == 6){
      week = "星期六"
    }else if(num == 6){
      week = "星期六"
    }else if(num == 5){
      week = "星期五"
    }else if(num == 6){
      week = "星期六"
    }

    return week
  }
}
