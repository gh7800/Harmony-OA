import api from '../../http/Api'
import ApiResponse from '../../http/ApiRsponse'
import { ReportRequestParams } from '../../model/ReportRequestParams'

class ReportViewModel {
  getReportList(keyword : string | null,page: number): Promise<ApiResponse> {
    let params: ReportRequestParams = new ReportRequestParams(
       page, [111,112], keyword
    )
    return new Promise((resolve) => {
      api.get("api/document/todo", params)
        .then(response => {
          resolve(response)
        })
    })
  }
}

const mReportViewModel = new ReportViewModel()
export default mReportViewModel
