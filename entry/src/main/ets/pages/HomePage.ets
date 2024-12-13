import {ConstantUtil} from '../utils/ConstantUtil'
import preferenceUtil from '../utils/PreferencesUtil'
import { LogUtils, RouterUtil } from 'librarycommon'
import { DateTimeUtil } from '../utils/DateTimeUtil'

@Component
export struct HomePage {
  @State realName: string = ''
  @State dateTime : string = ""
  private menuTitle: string[] = [
    '通知', '请示', '总办会', '党委会', '董事会',
    '内部发文', '公文流转', '用车', '会议', '资产管理',
    '公章证照', '周例会', '督办管理', '安全管理', '采购管理',
    '企业授权', '合同管理', '介绍信']
  private menuIcon = [
    $r('app.media.icon_home_tongzhi'), $r('app.media.icon_home_wenjian'), $r('app.media.icon_home_wenjian'),$r('app.media.icon_home_wenjian'), $r('app.media.icon_home_wenjian'),
    $r('app.media.icon_home_jiancha'), $r('app.media.icon_home_yuedu'), $r('app.media.icon_home_cheliang'), $r('app.media.icon_home_meeting'), $r('app.media.icon_home_property'),
    $r('app.media.icon_home_shenpi'), $r('app.media.icon_jieshaoxin'),$r('app.media.icon_ducha'),$r('app.media.icon_safety'),$r('app.media.icon_caigou'),
    $r('app.media.icon_home_authorization'),$r('app.media.icon_home_hetong'),$r('app.media.icon_jieshaoxin'),
  ]

  aboutToAppear(){
    this.dateTime = DateTimeUtil.getDate()+ " " + DateTimeUtil.getWeek(DateTimeUtil.getDate())
    preferenceUtil.getString(ConstantUtil.REAL_NAME)
      .then((data: string) => {
        this.realName = data
      })
      .catch((err: string) => {
        LogUtils.error(err)
      })
  }

  @Styles
  commonStyle(){ //共有通用属性
    .margin({ left: 10, right: 10 })
    .height(45)
  }

  build() {
    NavDestination() {
      Column() {

        Row() {
          Text(this.dateTime)
            .commonStyle()
            .fontColor($r('app.color.f2'))

          Text('您好 ' + this.realName)
            .commonStyle()
            .fontColor($r('app.color.f2'))
        }
        .width('100%')
        .backgroundColor($r('app.color.main'))
        .justifyContent(FlexAlign.SpaceBetween)

        Column() {
          GridRow({ columns: 5 }) {
            ForEach(this.menuTitle, (item: string, index) => {
              GridCol() {
                Column() {
                  Image(this.menuIcon[index])
                    .width(35)
                    .height(35)

                  Text(item)
                    .margin({ top: 5, bottom: 5 })
                    .fontColor($r('app.color.c3'))
                    .fontSize(12)
                    .fontWeight(FontWeight.Normal)

                }
                .width(70)
                .height(70)
                .margin({ top: 2 })
                .justifyContent(FlexAlign.Center)
                .backgroundColor($r('app.color.write'))
                .onClick((event) => {
                  switch (index) {
                    case 0:
                      const parm: String = '随便传就行';
                      RouterUtil.push("NotificationsPage", parm, async (info) => {
                        LogUtils.errorAny(info.result)
                      })
                      break
                    case 1:
                      RouterUtil.push("ReportPage")
                      break

                    default:
                      break
                  }
                })
              }
            })
          }
          .width('100%')
          .margin({ top: 2, left: 2, right: 2 })
          .backgroundColor($r('app.color.write'))

        }

      }
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.f2'))
    }
    .onShown(()=>{
      LogUtils.error("onShown")
      preferenceUtil.getString(ConstantUtil.REAL_NAME)
        .then((data: string) => {
          this.realName = data
        })
        .catch((err: string) => {
          LogUtils.error(err)
        })
    })
  }

}

