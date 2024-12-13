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
      Text(this.title).fontColor(this.isCurrent ? $r('app.color.main') : $r('app.color.c6')).lineHeight(22).margin({bottom:7})
      Divider().color(this.isCurrent ? $r('app.color.main') : $r('app.color.c6')).width(this.title.length * 12).strokeWidth(2).borderRadius(4)
    }
  }
}