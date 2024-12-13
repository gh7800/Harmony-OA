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
        Image($r('app.media.image_file_empty'))
          .width('100')
          .height('100')
        Text("~暂无数据~").width('100').textAlign(TextAlign.Center)
      }
      .backgroundColor($r('app.color.f2'))
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
}