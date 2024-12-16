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
  @State uuid: string = ""
  private reportModel: ReportModel | null = null
  private loading = new CustomDialogController({
    builder: LoadingDialog(),
    customStyle: true,
    cancel: () => {
      api.cancelRequest()
    }
  })

  aboutToAppear(): void {
    mReportViewModel.getReportDetail(this.uuid)
      .then((response) => {
        if (response.success) {
          this.reportModel = response.data as ReportModel
        } else {
          this.hideLoading(response.message)
        }
      })
  }

  showLoading() {
    this.loading.open()
  }

  hideLoading(err : string | null) {
    this.loading.close()
    ToastUtil.show(err)
  }

  build() {
    NavDestination() {
      Column() {
        TitleBarComponent({ title: '详情' })
        if (this.reportModel != null) {
          TitleContentComponent({ title: "标题：", content: this.reportModel.title })
          TitleContentComponent({ title: "内容：", content: this.reportModel.content })
          TitleContentComponent({ title: "文号：", content: this.reportModel.number })
          TitleContentComponent({ title: "标题：", content: this.reportModel.title })
          TitleContentComponent({ title: "标题：", content: this.reportModel.title })
        } else {
          EmptyComponent()
        }

      }
      .backgroundColor($r('app.color.f2'))
      .width('100%')
      .height('100%')
    }
    .hideTitleBar(true)
    .onReady((context) => {
      this.uuid = context.pathInfo.param as string
      LogUtils.error(this.uuid)
    })
    .onBackPressed(() => {
      RouterUtil.pop("OK")
      return true
    })
  }
}