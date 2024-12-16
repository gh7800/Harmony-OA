/**
 *
 */
// @Preview
@Component
export struct TitleContentComponent {
  @Prop title: string
  @Prop content: string
  @State mWidth: string = '100%'
  @State mHeight: string = '40' //高度自适应
  @State needIcon: boolean = false //是否需要右侧箭头>
  @State needDrive: boolean = false //是否需要分割线

  build() {
    Column() {
      Row() {
        Text(this.title)
          .fontSize(16)
          .height('auto')
          .fontColor($r('app.color.c3'))
          .backgroundColor($r('app.color.write'))
          .padding({ left: 10 })
          .layoutWeight(1)

        Text(this.content)
          .height('auto')
          .padding({ left: 10, right: 10 })
          .fontSize(16)
          .fontColor($r('app.color.c6'))
          .layoutWeight(4)
          .textAlign(TextAlign.End)

        Image($r('app.media.ic_enter'))
          .width(22)
          .height(32)
          .margin({ right: 10 })
          .visibility(this.needIcon ? Visibility.Visible : Visibility.None)
      }
      .width(this.mWidth)
      .height(this.mHeight)

      Divider().width('100%').height('1')
    }
    .width("100%")
    .height(this.mHeight)
    .backgroundColor($r('app.color.write'))
    .padding({top:1,bottom:1})
  }

}