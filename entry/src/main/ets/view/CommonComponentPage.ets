import { TitleBarComponent } from "./TitleBarComponent"

/**
 * 2024/10/14
 * GF63 通用组件使用测试
 */
@Builder
function CommonComponentPageBuilder() {
  CommonComponentPage()
}

@Component
export struct CommonComponentPage {
  private data: Array<string> = ['选择时间', 'PopWindow', 'TreeView', '多媒体', '']

  build() {
    NavDestination() {
      Column() {
        TitleBarComponent({ title: "常用组件添加" })

        Grid() {
          ForEach(this.data, (value: string, index) => {
            GridItem() {
                Text(value).width('30%').height(40).borderRadius(6).borderWidth(2)
                  .borderColor($r('app.color.grayNormal'))
                  .textAlign(TextAlign.Center)
            }
          })
        }
        .width('100%')
        .height('100%')
        .layoutWeight(1)
        .columnsGap(10)
        .rowsGap(10)
        .margin({top:10,left: 10})
      }
      .backgroundColor($r('app.color.f2'))
      .width('100%')
      .height('100%')
    }
    .hideTitleBar(true)
  }
}