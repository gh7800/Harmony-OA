import { LogUtil, RouterUtil, ToastUtil } from 'librarycommon'
import api from '../../http/Api'
import ApiResponse from '../../http/ApiRsponse'
import NotificationModel from '../../model/NotificationModel'
import LoadingDialog from '../../view/LoadingDialog'
import { TitleBarComponent } from '../../view/TitleBarComponent'
import { TitleContentComponent } from '../../view/TitleContentComponent'

/**
 * 这是：通知详情
 * created by: 2024/6/3
 */
@Builder
export function NotificationDetailPageBuilder() {
  NotificationDetailPage()
}

@Component
struct NotificationDetailPage {
  @State title: string = ""
  @State uuid: string = ""
  @State notificationModel: NotificationModel = new NotificationModel("","","","")

  loading = new CustomDialogController({
    builder: LoadingDialog(),
    customStyle: true,
    cancel: () => {
      ToastUtil.show('已取消')
    }
  })

  aboutToAppear() {}

  async getData(){
    this.loading.open()
    try {
      const response : ApiResponse<NotificationModel> = await api.get("api/notice/message/"+this.uuid)
      if(response.success){
        this.notificationModel = response.data
        this.loading.close()
      }else {
        this.loading.close()
      }
    } catch (error) {
      this.loading.close()
      ToastUtil.show(error)
    }

  }

  build() {
    NavDestination() {
      Column() {
        TitleBarComponent({title:this.title,isClickBack: true,clickBack:()=>{
          const param = 100
          RouterUtil.pop(param)
        }})

        ColumnSplit() {
          TitleContentComponent({ title: '标题：', content: this.notificationModel.title, mHeight: '40' })
          TitleContentComponent({ title: '内容：', content: this.notificationModel.content })
          TitleContentComponent({ title: '创建时间：', content: this.notificationModel.created_at, mHeight: '40' })
        }
        .backgroundColor($r('app.color.f2'))
      }
      .width('100%')
      .height('100%')
    }
    .hideTitleBar(true)
    .onReady(context=>{
      LogUtil.errorJson(context.pathInfo)

     /* let record = context.pathInfo.param as Record<string,string>
      this.uuid = record["uuid"]
      this.title = record["title"]*/

      const record = context.pathInfo.param as NotificationModel
      this.title = record.title
      this.uuid = record.uuid

      this.getData()
    })
  }
}




