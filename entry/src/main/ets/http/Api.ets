import axios, { AxiosError, AxiosInstance, AxiosRequestConfig, AxiosResponse,
  InternalAxiosRequestConfig } from '@ohos/axios';
import { ConstantUtil } from '../utils/ConstantUtil';
import { AppGlobalContext } from '../utils/AppGlobalContext';
import ApiResponse from './ApiRsponse';
import { LogUtils,RouterUtil } from 'librarycommon';
import { PaginationModel } from '../model/PaginationModel';


// 创建一个自定义的 HTTP 客户端类
class Api {
  private axiosInstance: AxiosInstance;
  private token : string = AppGlobalContext.getContext().getString(ConstantUtil.TOKEN);

  private baseUrl() {
    if(!this.token){
      this.token = AppGlobalContext.getContext().getString(ConstantUtil.TOKEN);
    }
    return 'http://xcoa.hwapp.site/'
  }

  constructor() {
    this.axiosInstance = axios.create({
      // 在这里可以添加自定义配置，如 baseURL、headers 等
      baseURL: this.baseUrl(),
      timeout: 30000,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + this.token
      },
    });


    // 添加请求拦截器
    this.axiosInstance.interceptors.request.use(
      (config : InternalAxiosRequestConfig) => {
        //可添加token等
        console.error('token_' + this.token)
        this.token = AppGlobalContext.getContext().getString(ConstantUtil.TOKEN);

        if(this.token){
          config.headers.set('Authorization','Bearer '+this.token)
        }

        LogUtils.error(config.baseURL + "" +config.url)
        if (config.params) {
          LogUtils.errorJson(config.params)
        }

        return config
      },
      (error : string) => {
        LogUtils.error('拦截器_' + error)
        return Promise.reject(error)
      }
    );
  }

  // 发送 GET 请求
  public async get(url: string, params?: object): Promise<ApiResponse> {

    try {
      const response : AxiosResponse<ApiResponse> = await this.axiosInstance.get<ApiResponse>(url, { params })
      LogUtils.errorJson(response.data)
      return this.handleResponse(response)
    } catch (error) {
      return this.handleError(error) as Promise<ApiResponse>
    }
  }

  // 发送 POST 请求
  public async post(url: string, params: object): Promise<ApiResponse> {
    try {
      const response : AxiosResponse<ApiResponse> = await this.axiosInstance.post<ApiResponse>(url, null, { params: params })
      LogUtils.errorJson(response.data)
      return this.handleResponse(response)
    } catch (error) {
      return this.handleError(error) as Promise<ApiResponse>
    }
  }

  // 发送 PUT 请求
  public async put(url: string, params: object): Promise<ApiResponse> {
    try {
      const response : AxiosResponse<ApiResponse> = await this.axiosInstance.put<ApiResponse>(url, null, { params: params })
      LogUtils.errorJson(response.data)
      return this.handleResponse(response)
    } catch (error) {
      return this.handleError(error) as Promise<ApiResponse>
    }
  }

  // 发送 Delete 请求
  public async delete(url: string, params: object): Promise<ApiResponse> {
    try {
      const response : AxiosResponse<ApiResponse> = await this.axiosInstance.delete<ApiResponse>(url, { params: params })
      LogUtils.errorJson(response.data)
      return this.handleResponse(response)
    } catch (error) {
      return this.handleError(error) as Promise<ApiResponse>
    }
  }



  //取消请求
  public cancelRequest() {
    LogUtils.error('取消http请求')
    axios.CancelToken.source()
  }

  // 其他 HTTP 请求方法可以根据需要添加，如 put、delete 等

  // 处理响应拦截
  private handleResponse(response: AxiosResponse<ApiResponse>): ApiResponse {
    if (response && response.data) {
      const apiResponse = response.data
      return apiResponse
      /*if (apiResponse.success) {
        return apiResponse
      }else if(!apiResponse.success){
        return apiResponse
      } else {
        //throw new Error(apiResponse.message);
        return  new ApiResponse(false,"1",apiResponse.message,new PaginationModel(0,0,0))
      }*/
    } else {
      //throw new Error('ResponseBody—响应无效');
      return new ApiResponse(false,"","ResponseBody—响应无效",new PaginationModel(0,0,0))
    }
  }

  private handleError(error: Error): Promise<ApiResponse> {
    let msg = '发生未知错误';

    if (axios.isAxiosError(error)) {
      const axiosError : AxiosError = error ;

      const response : AxiosResponse | undefined = axiosError.response;
      if (response) {
        const status = response.status;

        LogUtils.error(response.status);
        //LogUtils.errorJson(response.data);

        if (status >= 500 && status < 600) {
          msg = `服务器错误_${status}`;
        } else if (status == 401) {
          msg = '认证错误';
          RouterUtil.push("LoginPage")
        } else if (status == 404) {
          msg = '参数错误404';
        } else {
          msg = response.data?.message || msg;
        }
      }
    } else if (error instanceof Error) {
      msg = `其他错误___${error.message}`;
    }

    //return Promise.reject(new Error(msg));
    return Promise.resolve(new ApiResponse(false,"",msg,new PaginationModel(0,0,0)))
  }

}

// 创建实例，这样你可以在应用的其他地方使用同一个实例
const api = new Api();

export default api;
