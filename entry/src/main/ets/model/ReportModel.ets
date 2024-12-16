export default class ReportModel{
  id?: number
  uuid?: string
  user_uuid?: string
  user_title?: string
  step?: number
  company_uuid?: string
  department_uuid?: string
  category?: number
  type?: number
  source?: number
  date?: string
  number?: string
  title?: string
  content?: string
  main?: string
  publicity?: string
  publish?: string
  duration?: string
  archive?: string
  contacts?: string
  phone?: string
  status?: string
  reply?: string
  created_at?: string
  updated_at?: string
  external_org?: string
  external_time?: string
  external_class?: string
  present_to?: number
  reviewed_by?: string
  reviewed_at?: string
  reviewer?: string
  holder_uuid?: string
  approval_form?: string
  approval_forms?: Approval_forms[]
  classify?:string[]
  num1?: string
  num2?: string
  num3?: string
  next?: Next[]
  type_title?: string
  step_title?: string
  status_title?: string
  department_title?: string
  company_title?: string
  require_reply?: boolean
  approval_form_url?: string
  files?: Files[]
  tasks?: Tasks[]
  logs?: Logs[]
}

export class Logs {
  id?: number
  document_id?: number
  flow_id?: string
  step?: number
  title?: string
  user_title?: string
  user_uuid?: string
  result?: number
  reply?: string
  flag?: number
  created_at?: string
  department_title?: string
  approval_time?: string
}

export class Tasks {
  id?: number
  document_id?: number
  flow_id?: string
  step?: number
  title?: string
  user_title?: string
  user_uuid?: string
  role_uuid?: string
  flag?: number
  created_at?: string
}

export class Files {
  id?: number
  document_id?: number
  path?: string
  title?: string
  created_at?: string
  file_url?: string
}

export class Next {
}

export class Approval_forms {
}

