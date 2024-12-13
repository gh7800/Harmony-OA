import { PullToRefresh, PullToRefreshConfigurator } from "@ohos/pulltorefresh"
import { LogUtils, RouterUtil, ToastUtil } from "librarycommon"
import api from "../../http/Api"
import { UserManager } from "../../manager/UserManager"
import ReportModel from "../../model/ReportModel"
import { CustomTabBuilder } from "../../view/CustomTabBuilder"
import { EmptyComponent } from "../../view/EmptyComponent"
import LoadingDialog from "../../view/LoadingDialog"
import { TitleBarComponent } from "../../view/TitleBarComponent"
import mReportViewModel from "./ReportViewModel"

/**
 * page ：请示报告-列表页
 * created by: 2024/8/11
 */
@Builder
export function ReportPageBuilder() {
  ReportPage()
}

@Component
struct ReportPage {
  @State tabList : Array<string> = new Array("待处理","已处理","我申请的")
  @State data: Array<ReportModel> = new Array<ReportModel>()
  @State isShowLoading: boolean = true
  @State currentIndex: number = 0
  @State page: number = 1
  @State totalNum: number = 0
  @State keyword: string | null = null
  private tabText : string = this.tabList[0]

  private refreshConfig = new PullToRefreshConfigurator().setRefreshColor("#00B785").setLoadTextLoading('加载中')
  private scroller = new Scroller()
  private loading = new CustomDialogController({
    builder: LoadingDialog(),
    customStyle:true,
    cancel: () => {
      api.cancelRequest()
    }
  })

  aboutToAppear(): void {
    if(UserManager.isXingBan()){
      this.tabList.push("全部的")
    }

    this.showLoading()
    this.getData()
  }

  aboutToDisappear(): void {

  }

  private async getData(): Promise<boolean> { //增加异步函数回调 async promise await
    if(this.data.length > 0 && this.page == 1){
      this.data.length = 0
    }
    await mReportViewModel.getReportList(this.tabText,this.keyword,this.page)
      .then(response => {

        let list = response.data as Array<ReportModel>
        let pagination = response.pagination
        if (pagination.current_page > 1) {
          this.data.push(...list)
        } else {
          this.data = list
        }

        this.totalNum = pagination.total

        this.hideLoading(response.success ? '' : response.message)
        this.refreshConfig.setHasLoadMore(pagination.current_page < pagination.last_page)

      })

    return new Promise<boolean>((resolve, reject) => {
      resolve(true)
    })
  }

  @Builder
  ListView() {
    List({ space: 10, scroller: this.scroller }) {
      if(this.data.length > 0) {
        ForEach(this.data, (item: ReportModel, index: number) => {
          ListItem() {
            Column() {
              Text('标题：' + item.title).width("100%")
              Text('内容：' + item.content).margin({ top: 5 }).width("100%")
            }
            .padding({
              left: 10,
              right: 10,
              top: 10,
              bottom: 10
            })
            .margin({ top: 10 })
            .onClick(() => {
              let uuid = item.uuid
              RouterUtil.push("ReportDetailPage", uuid, (callback) => {
                this.page == 1
                this.showLoading()
                this.getData()
              })
            })
          }
          .margin({ left: 10, right: 10 })
          .backgroundColor($r('app.color.write'))
        })
      }else {
        EmptyComponent().onClick(() => {
          this.showLoading()
          this.getData()
        })
      }
    }
    .layoutWeight(1)
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.f2'))
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.None) // 必须设置列表为滑动到边缘无效果
  }

  @Builder
  TabBuilder(title: string, targetIndex: number) {
    CustomTabBuilder({ title: title, isCurrent: this.currentIndex == targetIndex })
  }

  showLoading() {
    if (this.isShowLoading) {
      this.loading.open()
    }
  }

  hideLoading(msg ?: string) {
    this.loading.close()
    this.isShowLoading = true //加载完成
    if (msg) {
      ToastUtil.show(msg)
    }
  }

  build() {
    NavDestination() {
      Column() {
        TitleBarComponent({ title: "请示报告" })

        Tabs() {
          ForEach(this.tabList,(item : string,index:number)=>{
            TabContent().tabBar(this.TabBuilder(item, index))
          })
        }
        .barMode(BarMode.Fixed)
        .backgroundColor($r('app.color.write'))
        .animationDuration(1)
        .onTabBarClick(index => {
          this.currentIndex = index
          this.tabText = this.tabList[index]
          this.page = 1
          this.isShowLoading = true
          this.showLoading()
          this.getData()
        })
        .height(48)

        TextInput({ placeholder: '关键字'})
          .textAlign(TextAlign.Center)
          .margin({
            left: 10,
            right: 10,
            top: 10,
            bottom: 10
          })
          .backgroundColor($r('app.color.write'))
          .enterKeyType(EnterKeyType.Search)
          .onChange((value)=>{
            this.keyword = value
          })
          .onSubmit(() => {
            this.showLoading()
            this.page = 1
            this.getData()
          })

        PullToRefresh({
          data: this.data,
          refreshConfigurator: this.refreshConfig,
          scroller: this.scroller,
          customList: () => this.ListView(),
          onRefresh: () => {
            return new Promise((resolve, reject) => {
              this.page = 1
              this.isShowLoading = false
              this.getData().then(()=>{
                resolve("刷新成功")
              })
            })
          },
          onLoadMore: () => {
            return new Promise((resolve, reject) => {
              this.page++
              this.getData().then(() => {
                resolve("加载成功")
              })
            })
          },
          customLoad: null,
          customRefresh: null
        })
          .layoutWeight(1)

        Text('共' + this.totalNum + '条').textAlign(TextAlign.Center).width('100%').height(60)

      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor($r('app.color.f2'))
    }
    .hideTitleBar(true)

  }
}
