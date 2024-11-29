/**
 * 2024/8/28
 * GF63
 * 通讯录
 */
@Component
export struct ContactPage {
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
      .backgroundColor($r('app.color.f2'))
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
  }
}