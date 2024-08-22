export default class NotificationModel{
  uuid : string
  title : string
  content : string
  created_at : string

  constructor(uuid: string, title: string, content: string, created_at: string) {
    this.uuid = uuid
    this.title = title
    this.content = content
    this.created_at = created_at
  }


}