
export class  ReportRequestParams {
  page: number
  type : Array<number>
  keyword : string | null

  constructor(page: number, type: Array<number>,keyword: string | null) {
    this.page = page
    this.type = type
    this.keyword = keyword
  }
}