/**
 * page ：通讯录
 * created by: 2024/8/14
 */
import router from '@ohos.router'

@Builder
export function ContactPageBuilder(){}

@Component
export struct ContactPage {
    build() {
        NavDestination() {
            Column() {
                Column() {
                    Text('页面')
                        .fontSize(24)
                        .margin({ top: 20 })
                    Button('Go Back')
                        .margin({ top: 20 })
                        .onClick(() => {
                            router.back()
                        })
                }
                .width('100%')
                .height('100%')
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)
            }
        }
    }
}
