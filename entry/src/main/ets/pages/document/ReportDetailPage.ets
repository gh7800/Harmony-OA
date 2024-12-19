import { LogUtils, RouterUtil, ToastUtil } from "librarycommon"
import api from "../../http/Api"
import ReportModel from "../../model/ReportModel"
import { EmptyComponent } from "../../view/EmptyComponent"
import LoadingDialog from "../../view/LoadingDialog"
import { TitleBarComponent } from "../../view/TitleBarComponent"
import { TitleContentComponent } from "../../view/TitleContentComponent"
import mReportViewModel from "./ReportViewModel"

/**
 * 2024/12/11
 * GF63
 * 请示报告详情,111请示/112报告
 */
@Builder
export function ReportDetailPageBuilder() {
  ReportDetailPage()
}

@Component
export struct ReportDetailPage {
  private scroller = new Scroller();
  @State uuid: string = ""
  @State reportModel: ReportModel | null = null
  private loading = new CustomDialogController({
    builder: LoadingDialog(),
    customStyle: true,
    cancel: () => {
      api.cancelRequest()
    }
  })

  aboutToAppear(): void {
  }

  getDetail() {
    this.showLoading()
    mReportViewModel.getReportDetail(this.uuid)
      .then((response) => {
        if (response.success) {
          this.hideLoading('1')
          this.reportModel = response.data as ReportModel
          LogUtils.error(this.reportModel.title)
        } else {
          this.hideLoading("2")
        }
      })
  }

  showLoading() {
    this.loading.open()
  }

  hideLoading(err: string | null = null) {
    this.loading.close()
    ToastUtil.show(err)
  }

  build() {
    NavDestination() {
      Column() {
        TitleBarComponent({ title: '详情' })
        List({ scroller: this.scroller }) {
          if (this.reportModel != null) {
            TitleContentComponent({ title: "标题：", content: this.reportModel?.title,mHeight:'auto'})
            TitleContentComponent({ title: "内容：", content: this.reportModel?.content, mHeight: 'auto' })
            TitleContentComponent({ title: "文号：", content: this.reportModel?.number })
          } else {
            EmptyComponent()
          }
        }
        .scrollBar(BarState.On)
        .width("100%")
        .height("100%")
      }
      .backgroundColor($r('app.color.f2'))
      .width('100%')
      .height('100%')
    }
    .hideTitleBar(true)
    .onReady((context) => {
      this.uuid = context.pathInfo.param as string
      this.getDetail()
    })
    .onBackPressed(() => {
      RouterUtil.pop("OK")
      return true
    })
  }
}