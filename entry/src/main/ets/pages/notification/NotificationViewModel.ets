import ApiResponse from '../../http/ApiRsponse'
import api from '../../http/Api'

class NotificationViewModel {
  getNotificationList(page: number): Promise<ApiResponse> {
    const params: RequestParams = {
      page: page
    }
    return new Promise((resolve, reject) => {
      api.get('api/notice/message', params)
        .then((data) => {
          resolve(data)
        })
    })

  }

  getNotificationDetail(uuid : string): Promise<ApiResponse> {
    return new Promise((resolve)=>{
      api.get("api/notice/message/"+uuid)
        .then((data) => {
          resolve(data)
        })
    })
  }
}

let viewModel = new NotificationViewModel()
export default viewModel

interface RequestParams {
  page: number;
}