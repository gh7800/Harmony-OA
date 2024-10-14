import api from '../../http/Api'
import ApiResponse from '../../http/ApiRsponse'

class ReportViewModel {
  getReportList(page: number): Promise<ApiResponse> {
    let params: RequestParams = {
      page: page,
      type: [111,112]
    }
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

interface RequestParams {
  page: number,
  type : Array<number>
}