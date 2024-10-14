// API 响应的数据结构
import { PaginationModel } from '../model/PaginationModel';

export default class ApiResponse {
  public data: string | object | ArrayBuffer;
  public success: boolean;
  public message: string;
  public pagination : PaginationModel ;

  constructor(success : boolean,data : string | object | ArrayBuffer,message : string,pagination : PaginationModel) {
    this.data = data
    this.success = success
    this.message =message
    this.pagination = pagination

    /*if(!success){
      throw new Error(message)
    }*/
  }
}