import { TitleBarComponent } from '../view/TitleBarComponent';
import { HomePage } from './HomePage'
import { MinePage } from './MinePage'
import { ContactPage } from './contact/ContactPage'
import { WorkingPage } from './working/WorkingPage'
import { LogUtil, RouterUtil, TimeUtil, ToastUtil } from 'librarycommon';
import App from '@system.app';
import { common } from '@kit.AbilityKit';

@Builder
export function MainPageBuilder() {
  MainPage()
}

@Entry
@Component
struct MainPage {
  tabsController: TabsController = new TabsController();
  @State currentIndex: number = 0
  private tabTitles: string[] = ['首页', '通讯录', '工作', '我的']
  @State title: string = this.tabTitles[0]
  @StorageProp('bottomHeight') bottomHeight: number = 20;
  private lastClickTime = 0
  private EXIT_INTERVAL : number = 2000

  //自定义tab
  @Builder
  TabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex == targetIndex ? selectedImg : normalImg)
        .size({ height: 26, width: 22 })
      // .margin({ top: 2 })
      Text(title)
        .fontColor(this.currentIndex == targetIndex ? $r('app.color.main') : $r('app.color.c6'))
        .fontSize(14)
        .margin({ bottom: 2, top: 2 })
    }
    .width(100)
    .height('100%')
    .backgroundColor($r('app.color.write'))
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = targetIndex
      this.tabsController.changeIndex(targetIndex) //tab切换页面
    })
  }

  aboutToAppear(): void {
  }

  onPageShow(): void {
  }

  @Builder
  pagesMap(name: string) {
    if ('首页' == name) {
      HomePage()
    } else if ("通讯录" == name) {
      ContactPage()
    } else if ('工作' == name) {
      WorkingPage()
    } else if ('我的' == name) {
      MinePage()
    }
  }

  build() {
    NavDestination() {

      Column() {
        TitleBarComponent({ title: this.title, isNeedBack: false })

        Tabs({
          barPosition: BarPosition.End,
          controller: this.tabsController
        }) {
          TabContent() {
            HomePage() //@Link 使用$
          }
          .tabBar(this.TabBuilder('首页', 0, $r('app.media.home_pressed'), $r('app.media.home_normal')))

          TabContent() {
            ContactPage()
          }
          .tabBar(this.TabBuilder('通讯录', 1, $r('app.media.contact_pressed'), $r('app.media.contact_normal')))

          TabContent() {
            WorkingPage()
          }
          .tabBar(this.TabBuilder('工作', 2, $r('app.media.backlog_pressed'), $r('app.media.backlog_normal')))

          TabContent() {
            MinePage()
          }
          .tabBar(this.TabBuilder('我的', 3, $r('app.media.mine_pressed'), $r('app.media.mine_normal')))

        }
        .barWidth('100%')
        .barHeight(50)
        .layoutWeight(1)
        .barMode(BarMode.Fixed)
        //.onTabBarClick(index => {})
        .onChange((index) => {
          this.currentIndex = index
          this.title = this.tabTitles[index]
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.main'))

    }
    .hideTitleBar(true)
    .height("100%")
    .width('100%')
    .onBackPressed(()=>{
      const currentTIme = TimeUtil.getCurrentTimestamp()
      if(currentTIme - this.lastClickTime < this.EXIT_INTERVAL){
        RouterUtil.clearStack()
        RouterUtil.exitAPP(this)
      }else {
        ToastUtil.show("再点一次退出")
        this.lastClickTime = currentTIme
      }
      return true
    })
    //.mode(NavigationMode.Auto)

    // .onReady(context =>{
    //   this.pathStack = context.pathStack
    // })
    //.mode(NavigationMode.Auto)
    //.navDestination(this.pagesMap)
    // .hideTitleBar(true)
    // .title(this.title)
    // .backgroundColor($r('app.color.main'))
    //.titleMode(NavigationTitleMode.Mini)
    //.hideBackButton(true) //隐藏返回icon
    /*.toolbarConfiguration([
      {
        value: "首页", icon: $r('app.media.home_normal'),status : ToolbarItemStatus.ACTIVE,activeIcon : $r('app.media.home_pressed'), action: () => {
        this.title = this.tabTitles[0]
      }
      },
      {
        value: "通讯录", icon: $r('app.media.contact_normal'),activeIcon : $r('app.media.contact_pressed'), action: () => {
        this.title = this.tabTitles[1]
        toastUtil.show(this.title)
        this.pagesMap(this.title)
      }
      },
      {
        value: "工作", icon: $r('app.media.work_normal'),activeIcon : $r('app.media.work_pressed'), action: () => {
        this.title = this.tabTitles[2]
      }
      },
      {
        value: "我的", icon: $r('app.media.ic_mine_normal'),activeIcon : $r('app.media.mine_pressed'), action: () => {
        this.title = this.tabTitles[3]
      }
      },
    ])*/
    // }
  }

}