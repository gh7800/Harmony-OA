
/**
 * page ：请示报告列表页
 * created by: 2024/8/11
 */
@Builder
export function ReportPageBuilder(){
  ReportPage()
}

@Component
struct ReportPage {
  build() {
    NavDestination() {
      Column() {
        Text('页面')
          .fontSize(24)
          .margin({ top: 20 })
        Button('Go Back')
          .margin({ top: 20 })
          .onClick(() => {

          })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .title("请示报告",{backgroundColor:$r('app.color.main')})
  }
}
