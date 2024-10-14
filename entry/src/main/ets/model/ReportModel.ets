export default class ReportModel{
  uuid: String
  title: String
  content: String

  constructor(uuid: String, title: String, content: String) {
    this.uuid = uuid
    this.title = title
    this.content = content
  }
}