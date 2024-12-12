import { LogUtils, RouterUtil } from "librarycommon"
import { TitleBarComponent } from "../../view/TitleBarComponent"

/**
 * 2024/12/11
 * GF63
 * 请示报告详情
 */
@Builder
export function ReportDetailPageBuilder(){
   ReportDetailPage()
}

@Component
export struct ReportDetailPage {
  @State uuid: string = ""

  build() {
    NavDestination() {
      Column() {
        TitleBarComponent({title:'详情'})

        Text('页面')
          .fontSize(24)
          .margin({ top: 20 })
        Button('Go Back')
          .margin({ top: 20 })
          .onClick(() => {
            RouterUtil.pop("OK")
          })
      }
      .backgroundColor($r('app.color.f2'))
      .width('100%')
      .height('100%')
    }
    .hideTitleBar(true)
    .onReady((context)=>{
      this.uuid = context.pathInfo.param as string
      LogUtils.error(this.uuid)
    })
    .onBackPressed(()=>{
      RouterUtil.pop("OK")
      return true
    })
  }
}