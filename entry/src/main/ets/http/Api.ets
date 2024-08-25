import axios, { AxiosError, AxiosInstance, AxiosRequestConfig, AxiosResponse,
  InternalAxiosRequestConfig } from '@ohos/axios';
import constantUtil from '../utils/ConstantUtil';
import { AppGlobalContext } from '../utils/AppGlobalContext';
import ApiResponse from './ApiRsponse';
import router from '@ohos.router'
import { LogUtil } from 'librarycommon';
import routerUtils from '../utils/RouterUtils';


// 创建一个自定义的 HTTP 客户端类
class Api {
  private axiosInstance: AxiosInstance;
  private token : string = AppGlobalContext.getContext().getString(constantUtil.TOKEN);

  private baseUrl() {
    return 'http://xcoa.hwapp.site/'
  }

  constructor() {
    this.axiosInstance = axios.create({
      // 在这里可以添加自定义配置，如 baseURL、headers 等
      baseURL: this.baseUrl(),
      timeout: 20000,
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
        this.token = AppGlobalContext.getContext().getString(constantUtil.TOKEN);

        if(this.token){
          config.headers.set('Authorization','Bearer '+this.token)
        }

        //console.error("Request：" + config.method + '__' + config.baseURL + config.url)
        //logUtil.error(this.baseUrl() + '_' + config.url)

        if (config.params) {
          LogUtil.errorJson(config.params)
        }

        return config
      },
      (error : string) => {
        LogUtil.error('拦截器_' + error)
        return Promise.reject(error)
      }
    );
  }

  // 发送 GET 请求
  public async get<T>(url: string, params: object): Promise<ApiResponse<T>> {

    try {
      const response : AxiosResponse<ApiResponse<T>> = await this.axiosInstance.get<ApiResponse<T>>(url, { params })
      return this.handleResponse(response)
    } catch (error) {
      return this.handleError(error)as Promise<ApiResponse<T>>
    }

    /*return await this.axiosInstance.get<ApiResponse<T>>(url, { params })
      .then(response => {
        let apiResponse = this.handleResponse(response)
        if (apiResponse.success) {
          return apiResponse
        } else {
          //throw new Error(apiResponse.message)
          this.handleError(apiResponse.message)
        }
      })
      .catch(this.handleError)*/
  }

  // 发送 POST 请求
  public async post<T>(url: string, params: object): Promise<ApiResponse<T>> {
    try {
      const response : AxiosResponse<ApiResponse<T>> = await this.axiosInstance.post<ApiResponse<T>>(url, null, { params: params })
      return this.handleResponse(response)
    } catch (error) {
      return this.handleError(error) as Promise<ApiResponse<T>>
    }
    /*return await this.axiosInstance.post<ApiResponse>(url, null, {
      params: params
    })
      .then(response => {
        let apiResponse = this.handleResponse(response)
        if (apiResponse.success) {
          return apiResponse
        } else {
          this.handleError(apiResponse.message)
        }
      })
      .catch(this.handleError)*/
  }

  //取消请求
  public cancelRequest() {
    LogUtil.error('取消')
    axios.CancelToken.source()
  }

  // 其他 HTTP 请求方法可以根据需要添加，如 put、delete 等

  // 处理响应拦截
  private handleResponse<T>(response: AxiosResponse<ApiResponse<T>>): ApiResponse<T> {
    // 检查响应对象是否存在
    //console.error('response--：', JSON.stringify(response.data))
   // LogUtil.errorJson(response.data)

    /*if (response && response.data !== undefined && response.data !== null) {
      return response.data;
    } else {
      // 如果响应对象或响应体不存在，返回一个默认值或者抛出错误，根据需要调整
      //throw new Error('Invalid response or empty response body');

      this.handleError('Invalid response or empty response body')
    }*/

    if (response && response.data) {
      const apiResponse = response.data;
      if (apiResponse.success) {
        return apiResponse;
      } else {
        throw new Error(apiResponse.message);
      }
    } else {
      throw new Error('Invalid response or empty response body');
    }
  }

  private handleError(error: Error): Promise<ApiResponse<null>> {
    let msg = 'An unknown error occurred';

    if (axios.isAxiosError(error)) {
      const axiosError : AxiosError = error ;

      const response : AxiosResponse | undefined = axiosError.response;
      if (response) {
        const status = response.status;

        LogUtil.error(response.status);
        LogUtil.errorJson(response.data);

        if (status >= 500 && status < 600) {
          msg = `服务器错误_${status}`;
        } else if (status == 401) {
          msg = '认证错误';
          routerUtils.replaceUrl({ url: 'pages/login/LoginPage' }, router.RouterMode.Single);
        } else if (status == 404) {
          msg = '参数错误404';
        } else {
          msg = response.data?.message || msg;
        }
      }
    } else if (error instanceof Error) {
      msg = `其他错误___${error.message}`;
    }

    return Promise.reject(new Error(msg));
  }


  // 处理请求错误
  /*private handleError(error: unknown) {
    // 这里可以添加一些全局的错误处理逻辑
    // logUtil.error('请求错误__' + error)

    let msg = error;
    if (axios.isAxiosError(error)) {
      let response = error.response

      //logUtil.error(JSON.stringify(response.data) + '___' + response.status)
      LogUtil.error(response.status)
      LogUtil.errorJson(response.data)

      var status = response.status
      if (status >= 500 && status < 600) {
        msg = '服务器错误_' + status
      } else if (status == 401) {
        msg = '认证错误'
        router.replaceUrl({ url: 'pages/LoginPage' }, router.RouterMode.Single)
      } else if (status == 404) {
        msg = '参数错误404'
      } else {
        msg = JSON.stringify(error.response.data.message)
      }

      msg = error.response.data.message

    } else {
      msg = '其他错误___' + error
    }

    return Promise.reject(msg);
    // return new ApiResponse(false, null, msg)
  }*/
}

// 创建实例，这样你可以在应用的其他地方使用同一个实例
const api = new Api();

export default api;
