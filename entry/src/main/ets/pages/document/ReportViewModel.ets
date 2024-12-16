import api from '../../http/Api'
import ApiResponse from '../../http/ApiRsponse'
import { ReportRequestParams } from '../../model/ReportRequestParams'

class ReportViewModel {
  getReportList(tabText : string,keyword : string | null,page: number): Promise<ApiResponse> {
    let params: ReportRequestParams = new ReportRequestParams(
       page, [111,112], keyword
    )
    return new Promise((resolve) => {
      if(tabText == "待处理") {
        api.get("api/document/todo", params)
          .then(response => {
            resolve(response)
          })
      }else if(tabText == "已处理"){
        api.get("api/document/finish", params)
          .then(response => {
            resolve(response)
          })
      }else if(tabText == "我申请的"){
        api.get("api/document/my-report", params)
          .then(response => {
            resolve(response)
          })
      }else if(tabText == "全部的"){
        api.get("api/document/report", params)
          .then(response => {
            resolve(response)
          })
      }
    })
  }

  getReportDetail(uuid : string): Promise<ApiResponse>{
    return new Promise(resolve => {
      api.get("api/document/report/" + uuid)
        .then(response => {
          resolve(response)
        })
    })
  }
}

const mReportViewModel = new ReportViewModel()
export default mReportViewModel
