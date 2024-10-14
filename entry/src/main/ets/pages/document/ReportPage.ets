import { PullToRefresh, PullToRefreshConfigurator } from "@ohos/pulltorefresh"
import api from "../../http/Api"
import ReportModel from "../../model/ReportModel"
import { CustomTabBuilder } from "../../view/CustomTabBuilder"
import LoadingDialog from "../../view/LoadingDialog"
import { TitleBarComponent } from "../../view/TitleBarComponent"
import mReportViewModel from "./ReportViewModel"

/**
 * page ：请示报告列表页
 * created by: 2024/8/11
 */
@Builder
export function ReportPageBuilder() {
  ReportPage()
}

@Component
struct ReportPage {
  @State data: Array<ReportModel> = new Array<ReportModel>()
  @State isRefresh: boolean = false
  @State currentIndex : number = 0
  @State page : number = 1
  private refreshConfig = new PullToRefreshConfigurator().setRefreshColor('app.color.main')
  private scroller = new Scroller()

  loading = new CustomDialogController({
    builder: LoadingDialog(),
    customStyle: true,
    cancel: () => {
      api.cancelRequest()
    }
  })

  aboutToAppear(): void {
    this.getData()
  }

  private getData() {
    mReportViewModel.getReportList(this.page)
      .then(response=>{

      })
  }

  @Builder
  ListView() {
    List({ space: 10, scroller: this.scroller }) {
      ForEach(this.data, (item: ReportModel, index: number) => {
        ListItem() {
          Column() {
            Text('标题：' + item.title)
          }
          .onClick(() => {

          })
        }
      })
    }
    .layoutWeight(1)
    .height('100%')
    .width('100%')
    .margin({ left: 10, right: 10 })
    .backgroundColor($r('app.color.f2'))
    .edgeEffect(EdgeEffect.None) // 必须设置列表为滑动到边缘无效果
  }

  @Builder
  TabBuilder(title : string,targetIndex: number){
    CustomTabBuilder({title: title,isCurrent:this.currentIndex == targetIndex})
  }

  build() {
    NavDestination() {
      Column() {
        TitleBarComponent({ title: "请示报告" })

        Tabs(){
          TabContent().tabBar(this.TabBuilder('待处理',0))
          TabContent().tabBar(this.TabBuilder('已处理',1))
          TabContent().tabBar(this.TabBuilder('全部的',2))
        }
        .barMode(BarMode.Fixed)
        .animationDuration(1)
        .onChange(index=>{
          this.currentIndex = index
        })
        .onTabBarClick(index=>{
          this.currentIndex = index
        })
        .height(48)

        PullToRefresh({
          data: this.data,
          refreshConfigurator: this.refreshConfig,
          scroller: this.scroller,
          customList: () => this.ListView(),
          onRefresh: () => {
            return new Promise((resolve, reject) => {

            })
          },
          onLoadMore: () => {
            return new Promise((resolve, reject) => {

            })
          },
          customLoad: null,
          customRefresh: null
        })
          .layoutWeight(1)

        Text('共xxx条').textAlign(TextAlign.Center).width('100%').height(60)

      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor($r('app.color.f2'))
    }
    .hideTitleBar(true)
    //.title("请示报告",{backgroundColor:$r('app.color.main')})
  }
}
