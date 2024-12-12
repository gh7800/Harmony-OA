/**
 * 自定义TabBar
 */
@Preview
@Component
export struct CustomTabBuilder{
  @Prop title: string = ''
  @Prop isCurrent: boolean = false

  build() {
    Column() {
      Text(this.title).fontColor(this.isCurrent ? $r('app.color.main') : $r('app.color.c3')).lineHeight(22).margin({bottom:7})
      Divider().color(this.isCurrent ? $r('app.color.main') : $r('app.color.c3')).width(36).strokeWidth(2).borderRadius(4)
    }
  }
}