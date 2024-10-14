/**
 * 单行 左右带图片的
 */
@Component
export struct CommonTitleContent {
  @Prop title: string
  @Prop content: string
  iconTitle: ResourceStr = ""
  iconRight: string = ""
  onclick: () => void = () => {
  }

  build() {
    Row() {
      Image(this.iconTitle)
        .width(22)
        .height(22)
        .visibility(this.iconTitle ? Visibility.Visible : Visibility.None)
        .margin({ left: 10 })
        .borderRadius(20)
      Text(this.title)
        .layoutWeight(1)
        .margin({ left: 10 })
        .fontSize(16)
      Text(this.content)
        .width(150)
        .textAlign(TextAlign.End)
        .fontSize(16)
      Image(this.iconRight ? this.iconRight : $r('app.media.ic_enter'))
        .width(40)
        .height(40)
    }
    .backgroundColor($r('app.color.write'))
    .borderRadius(8)
    .margin({ left: 10, top: 5, right: 10 })
    .padding({ top: 5, bottom: 5 })
    .onClick(() => {
      if (this.onclick) {
        this.onclick()
      }
    })
  }
}