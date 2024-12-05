## 鸿蒙OS APP

#### 1、项目 WanHarmony
#### 2、ts → ArkTs 方舟ts 开发语言
#### 3、ArkUI 方舟ui UI框架
#### 4、复制一份 build-profile.json5 
#### 5、所有的page页都要在 resources-base-profile-main_pages.json添加
#### 6、[TS基础语法链接](https://www.bookstack.cn/read/TypeScript-4.0-zh/5d2c2b5f1ef3a276.md)
#### 7、[鸿蒙Next语法链接](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkui-overview-V5)

```
/**
 * 声明变量--
 */
let global_num = 12          // 全局变量
class Numbers { 
   num_val = 13;             // 实例变量
   static sval = 10;         // 静态变量
   
   
   storeNum():void { 
      let local_num = 14;    // 局部变量
   } 
} 
```

#### 8、 页面与组件的生命周期
##### 页面生命周期，即被@Entry装饰的组件生命周期，提供以下生命周期接口：
##### onPageShow：页面每次显示时触发一次，包括路由过程、应用进入前台等场景。
##### onPageHide：页面每次隐藏时触发一次，包括路由过程、应用进入后台等场景。
##### onBackPress：当用户点击返回按钮时触发。
##### 组件生命周期，即一般用@Component装饰的自定义组件的生命周期，提供以下生命周期接口：
##### aboutToAppear：组件即将出现时回调该接口，具体时机为在创建自定义组件的新实例后，在执行其build()函数之前执行。
##### onDidBuild：组件build()函数执行完成之后回调该接口，不建议在onDidBuild函数中更改状态变量、使用animateTo等功能，这可能会导致不稳定的UI表现。
#####  aboutToDisappear：aboutToDisappear函数在自定义组件析构销毁之前执行。不允许在aboutToDisappear函数中改变状态变量，特别是@Link变量的修改可能会导致应用程序行为不稳定

---

![ArkTs](/image/s2.png)
![ArkTs](/image/s4.png)
![ArkTs](/image/s1.png)
#### UIAbility的生命周期，UIAbility的生命周期包括Create、Foreground、Background、Destroy四个状态，WindowStageCreate和WindowStageDestroy为窗口管理器（WindowStage）在UIAbility中管理UI界面功能的两个生命周期回调，从而实现UIAbility与窗口之间的弱耦合
![ArkTs](/image/s3.png)
