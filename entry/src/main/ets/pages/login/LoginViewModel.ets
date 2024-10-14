import api from "../../http/Api";
import ApiResponse from "../../http/ApiRsponse";

class LoginViewModel {
  login(username: string, password: string): Promise<ApiResponse> {
    let params: LoginParams = {
      username: username,
      password: password
    }
    return new Promise(async (resolve) => {
      api.post('/auth/login', params)
        .then((data: ApiResponse) => {
          resolve(data)
        })
    })
  }
}

let loginViewModel = new LoginViewModel()
export default loginViewModel

interface LoginParams {
  username: string,
  password: string,
}