
@Component
export struct SplashPage {
  @Link isSplash: boolean //双向绑定

  aboutToAppear(): void {

    setTimeout(() => {

      this.isSplash = false

    }, 3000)
  }

  build() {
      Row() {
        Column(
          {
            space: 10, //组件之间的间距
          }
        ) {

          Image($r('app.media.icon_logo_transparent'))
            .width(75)
            .height(75)

          Text("鸿蒙OS")
            .fontSize(16)
            .fontColor($r('app.color.write'))
            .margin({ top: 100 })

          Text('环雅丽都移动办公平台')
            .fontSize(22)
            .fontColor($r('app.color.write'))
            .margin({ top: 10 })
        }
        .width('100%')
        .padding(22)
      }
      .backgroundColor($r('app.color.main'))
      .height('100%')
      .alignItems(VerticalAlign.Bottom)
      .padding({ bottom: 100 })
    }
}