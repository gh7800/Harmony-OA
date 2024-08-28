import { PullToRefresh } from '@ohos/pulltorefresh/src/main/ets/components/PullToRefresh/PullToRefresh'
import { PullToRefreshConfigurator } from '@ohos/pulltorefresh'
import api from '../../http/Api'
import ApiResponse from '../../http/ApiRsponse'
import NotificationModel from '../../model/NotificationModel'
import { LogUtil, RouterUtil, ToastUtil } from 'librarycommon'

@Builder
export function NotificationsPageBuilder() : void{
  NotificationsPage()
}

@Entry
@Component
 struct NotificationsPage {
  @State data: Array<NotificationModel> = new Array()
  private scroller = new Scroller()
  private page = 1
  @State isRefresh: boolean = false
  private refreshConfig = new PullToRefreshConfigurator().setRefreshColor('#FF1874D7')

  aboutToAppear() {
    this.getData()
  }

  private async getData() {
    let params: RequestParams = {
      page: this.page
    }
    const response: ApiResponse<Array<NotificationModel>> = await api.get('api/notice/message', params)
    try {
      if (response.success) {
        if (response.pagination.current_page > 1) {
          response.data.map((value, index) => {
            this.data.push(value)
          })
          if (response.pagination.current_page >= this.page) {
            this.refreshConfig.setHasLoadMore(false)
          }
        } else {
          this.data = response.data
        }
      } else {
        ToastUtil.show(response.message)
      }
    } catch (error) {
      ToastUtil.show(error)
    }
  }

  @Builder
  refreshView() {
    List({ space: 10, scroller: this.scroller }) {
      ForEach(this.data, (item: NotificationModel, index: number) => {
        ListItem() {
          Column() {
            Text('标题：' + item.title)
              .maxLines(1)
              .width('100%')
              .textAlign(TextAlign.Start)
              .fontSize(16)
              .fontColor($r('app.color.c3'))
            Text('内容：' + item.content)
              .maxLines(1)
              .width('100%')
              .textAlign(TextAlign.Start)
              .fontColor($r('app.color.c6'))
            Text('创建时间：' + item.created_at).width('100%').textAlign(TextAlign.End).fontColor($r('app.color.c6'))
              .fontSize(14)
          }
          .onClick(event => {
            let item = this.data[index]
            const param : SendParams = {
              "title": item.title,
              "uuid": item.uuid
            }
            RouterUtil.push("NotificationDetailPage",param)
          })
        }
        .border({ radius: 5 })
        .padding({
          top: 5,
          left: 5,
          right: 5,
          bottom: 5
        })
        .backgroundColor($r('app.color.write'))
      })
    }
    .layoutWeight(1)
    .height('100%')
    .width('100%')
    .margin({ left: 10, right: 10 })
    .edgeEffect(EdgeEffect.None) // 必须设置列表为滑动到边缘无效果
  }

  @Builder
  NavigationTitle(title : string) {
    Column() {
      Text(title)
        .fontColor($r('app.color.write'))
        .fontSize(22)
    }
    .height(60)
    .padding({left:10})
    .justifyContent(FlexAlign.Center)
  }

  build() {
    NavDestination() {
      Column() {
        //TitleBarComponent({ title: '通知' })

        PullToRefresh({
          data: $data,
          refreshConfigurator: this.refreshConfig,
          scroller: this.scroller,
          customList: () => this.refreshView(),
          onRefresh: () => {
            return new Promise((resolve, reject) => {
              this.data = null

              this.page = 1
              this.getData()
              if (this.isRefresh) {
                resolve('加载成功')
              }
            })
          },
          onLoadMore: () => {
            return new Promise((resolve, reject) => {
              this.page++
              this.getData()
              if (this.isRefresh) {
                resolve('加载成功')
              }
            })
          },
          customLoad: null,
          customRefresh: null
        }
        )
          .layoutWeight(1)
          .padding({ top: 10, bottom: 10 })

      }
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.f2'))
      .justifyContent(FlexAlign.Start)
    }
    .title(this.NavigationTitle("通知"),{backgroundColor:$r('app.color.main')})
    .backButtonIcon($r('app.media.ic_back'))
    .systemBarStyle({statusBarContentColor:'#FFFFFF'})
  }
}


interface RequestParams {
  page: number;
}

interface SendParams {
  title: string;
  uuid: string;
}