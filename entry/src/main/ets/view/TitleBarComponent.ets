import { LogUtil, ToastUtil } from 'librarycommon'
import { RouterUtil } from 'librarycommon/src/main/ets/Utils/RouterUtil'

// 自定义titleBar组件
@Component
export struct TitleBarComponent {
  @Prop title: string
  @Prop menu ?: string = ''
  @Prop menuIcon ?: string = '' //传递 menuIcon:'ic_back.png'
  isNeedBack: boolean = true
  isClickBack: boolean = false //是否需要重写回退事件
  clickBack: () => void = () => {
  } //back
  clickMenu: () => void = () => {
  } //右侧menu点击事件回调
  bgColor = $r('app.color.main')

  build() {
    RelativeContainer() {
      Image($r('app.media.ic_back'))
        .width(30)
        .height(30)
        .visibility(this.isNeedBack ? Visibility.Visible : Visibility.Hidden)
        .alignRules({
          top: { anchor: '__container__', align: VerticalAlign.Top },
          bottom: { anchor: '__container__', align: VerticalAlign.Bottom }
        })
        .margin({ left: 10 })
        .id('backIcon')
        .onClick(() => {
          if (!this.isClickBack) {
            RouterUtil.pop()
          }else {
            this.clickBack()
          }
        })

      Text(this.title)
        .fontSize(18)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
        .padding({ left: 10, right: 10 })
        .margin({ right: 40 })
        .alignRules({
          left: { anchor: 'backIcon', align: HorizontalAlign.End },
          right: { anchor: '__container__', align: HorizontalAlign.End },
          top: { anchor: '__container__', align: VerticalAlign.Top },
          bottom: { anchor: '__container__', align: VerticalAlign.Bottom }
        })

      Text(this.menu)
        .visibility(this.menu ? Visibility.Visible : Visibility.None)
        .fontSize(16)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
        .margin({ right: 20 })
        .alignRules({
          right: { anchor: '__container__', align: HorizontalAlign.End },
          top: { anchor: '__container__', align: VerticalAlign.Top },
          bottom: { anchor: '__container__', align: VerticalAlign.Bottom }
        })
        .onClick(() => {
          if (this.clickMenu) {
            this.clickMenu()
          }
        })

      Image($rawfile(this.menuIcon))
        .height(30)
        .width(30)
        .margin({ right: 16 })
        .visibility(this.menuIcon ? Visibility.Visible : Visibility.None)
        .onClick(() => {
          if (this.clickMenu) {
            this.clickMenu()
          }
        })

    }
    .width('100%')
    .height(56)
    .backgroundColor(this.bgColor)
  }
}

