export class PaginationModel{
  total : number
  current_page : number = 1
  last_page : number

  constructor(total: number, current_page: number, last_page: number) {
    this.total = total
    this.current_page = current_page
    this.last_page = last_page
  }


}