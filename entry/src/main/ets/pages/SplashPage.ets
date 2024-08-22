import { LogUtil } from 'LibraryCommon'

@Builder
function SplashPageBuilder(){}

@Component
export struct SplashPage {
  @Link isSplash: boolean //双向绑定
  // @Consume pathStack : NavPathStack

  aboutToAppear(): void {

    setTimeout(() => {
      /*let url = 'LoginPage'

      preferenceUtil.getString(constantUtil.TOKEN)
        .then((data) => {
          if (data) {
            url = 'MainPage'
          }
        })
        .catch((err: string) => {
          toastUtil.show(err)
        })
        .finally(() => {
          this.startPage(url)
          //this.pathStack.pop(url)
        })*/

      this.isSplash = false

    }, 3000)
  }

  startPage(url: string) {
    //this.pathStack.replacePathByName(url, null)
  }

  build() {
    // NavDestination() {
      Row() {
        Column(
          {
            space: 10, //组件之间的间距
          }
        ) {

          Image($r('app.media.icon'))
            .width(100)
            .height(100)

          Text("鸿蒙OS")
            .fontSize(22)
            .margin({ top: 10 })
            .fontWeight(FontWeight.Bold)

          Button('移动办公', { type: ButtonType.Normal, stateEffect: true })
            .borderRadius(20)
            .margin({ top: 30 })
            .width(150)
            .onClick(() => {
              LogUtil.error('12312')
              //this.pathStack.pop("MainPage")
            })
        }
        .width('100%')
        .padding(22)
      }

      .height('100%')
      .alignItems(VerticalAlign.Bottom)
      .padding({ bottom: 100 })
    }
   /* .hideTitleBar(true)
    .onReady(context => {
      this.pathStack = context.pathStack
    })
  }*/
}