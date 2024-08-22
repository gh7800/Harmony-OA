// API 响应的数据结构
import { PaginationModel } from '../model/PaginationModel';

export default class ApiResponse<T> {
  public data: T;
  public success: boolean;
  public message: string;
  public pagination : PaginationModel ;

  constructor(success : boolean,data : T,message : string,pagination : PaginationModel) {
    this.data = data
    this.success = success
    this.message =message
    this.pagination = pagination

    if(!success){
      throw new Error(message)
    }
  }
}