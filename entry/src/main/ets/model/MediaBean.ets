/**
 * 多媒体数据类
 */
export class MediaBean {
  /**
   * 文件名称
   */
   fileName?: string;
  /**
   * 文件大小
   */
   fileSize?: number;
  /**
   * 文件类型
   */
   fileType?: string;
  /**
   * 本地存储地址
   */
   localUrl?: string;

  constructor(fileName? : string,fileSize? : number,fileType? : string,localUrl? : string) {
    this.fileName = fileName;
    this.fileSize = fileSize;
    this.fileType = fileType;
    this.localUrl = localUrl;
  }

}

