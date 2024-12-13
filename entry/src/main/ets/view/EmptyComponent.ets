/**
 * 2024/12/13
 * GF63
 * 空布局-组件
 */
@Preview
@Component
export struct EmptyComponent {
  build() {
      Column() {
        Image($r('app.media.image_car'))
          .width('200')
          .height('220')
        Text("~暂无数据~").width('100').textAlign(TextAlign.Center).margin({top:20})
      }
      .backgroundColor($r('app.color.f2'))
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
}