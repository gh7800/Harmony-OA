import common from '@ohos.app.ability.common';
import picker from '@ohos.file.picker';
import wantConstant from '@ohos.ability.wantConstant';
import { MediaBean } from '../model/MediaBean';

/**
 * 多媒体辅助类
 */
// export class MediaHelper {
//   private readonly TAG: string = 'MediaHelper';
//   private mContext: common.Context;
//
//   constructor(context: common.Context) {
//     this.mContext = context;
//   }
//
//   /**
//    * 选择图片
//    */
//
//   public selectPicture(): Promise<MediaBean> {
//
//     try {
//       let photoSelectOptions = new picker.PhotoSelectOptions();
//       photoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
//       photoSelectOptions.maxSelectNumber = 1;
//       let photoPicker = new picker.PhotoViewPicker();
//       return photoPicker.select(photoSelectOptions)
//         .then((photoSelectResult) => {
//           LogUtils.info(this.TAG,
//             'PhotoViewPicker.select successfully, PhotoSelectResult uri: ' + JSON.stringify(photoSelectResult));
//
//           if (photoSelectResult && photoSelectResult.photoUris && photoSelectResult.photoUris.length > 0) {
//             let filePath = photoSelectResult.photoUris[0];
//             LogUtils.info(this.TAG, 'PhotoViewPicker.select successfully, PhotoSelectResult uri: ' + filePath);
//             return filePath;
//           }
//
//         }).catch((err: string) => {
//           LogUtils.info(this.TAG, 'PhotoViewPicker.select failed with err: ' + err);
//           return err;
//         }).then(async (filePath: string) => {
//           const mediaBean = await this.buildMediaBean(filePath);
//           return mediaBean;
//         });
//     } catch (err) {
//       LogUtils.info(this.TAG, 'PhotoViewPicker failed with err: ' + err);
//       return Promise.reject(err);
//     }
//   }
//
//   /* *
//     * 选择文件*/
//
//   public selectFile(): Promise<MediaBean> {
//     try {
//       let documentSelectOptions = new picker.DocumentSelectOptions();
//       let documentPicker = new picker.DocumentViewPicker();
//       return documentPicker.select(documentSelectOptions)
//         .then((documentSelectResult) => {
//           LogUtils.errorJson(documentSelectResult)
//
//           if (documentSelectResult && documentSelectResult.length > 0) {
//             let filePath = documentSelectResult[0];
//             LogUtils.info(this.TAG, 'DocumentViewPicker.select successfully, DocumentSelectResult uri: ' + filePath);
//             return Promise.resolve(filePath);
//           }
//
//         }).then(async (filePath) => {
//
//           const mediaBean = await this.buildMediaBean(filePath);
//           return mediaBean;
//
//         }).catch((err: string) => {
//           LogUtils.error(err)
//           return Promise.reject(err);
//         });
//     } catch (err) {
//       LogUtils.info(this.TAG, 'PhotoViewPicker failed with err: ' + err);
//       return Promise.reject(err);
//     }
//   }
//
//
//   /**
//    * 拍照*/
//
//   public async takePhoto(context: common.UIAbilityContext): Promise<MediaBean> {
//
//
//     let want: wantParam = {
//       'uri': '',
//       'action': wantConstant.Action.ACTION_IMAGE_CAPTURE
//     };
//
//     return context.startAbilityForResult(want)
//       .then((result) => {
//         LogUtils.errorAny(result);
//         if (result.resultCode === 0 && result.want && result.want.uri) {
//           //拍照成功
//           LogUtils.error(result.want.uri);
//           // return result.want.uri;
//         }
//       })
//       .then((uri) => {
//         if (typeof uri === 'string') {
//         }
//         const mediaBean = this.buildMediaBean(uri as string);
//         return mediaBean;
//       })/*.catch((error) => {
//       LogUtils.info(this.TAG, `startAbility error , ${JSON.stringify(error)}`);
//       return error;
//     })*/;
//   }
//
//
//   /**
//    * 封装多媒体实体类
//    *
//    * @param uri 文件路径*/
//
//   private async buildMediaBean(uri: string): Promise<MediaBean> {
//
//     /*if (!uri) {
//       return null;
//     }*/
//
//     const mediaBean: MediaBean = new MediaBean();
//     mediaBean.localUrl = uri;
//     await this.appendFileInfoToMediaBean(mediaBean, uri);
//     return mediaBean;
//   }
//
//   /**
//    * 通过Uri查找所选文件信息，插入到MediaBean中
//    * @param mediaBean
//    * @param uri*/
//
//   private async appendFileInfoToMediaBean(mediaBean: MediaBean, uri: string) {
//
//     if (!uri) {
//       return;
//     }
//     let fileList: Array<mediaLibrary.FileAsset> = [];
//
//     const parts: string[] = uri.split('/');
//     const id: string = parts.length > 0 ? parts[parts.length - 1] : '-1';
//
//     try {
//
//       let media = mediaLibrary.getMediaLibrary(this.mContext);
//       let mediaFetchOptions: mediaLibrary.MediaFetchOptions = {
//         selections: mediaLibrary.FileKey.ID + '= ?',
//         selectionArgs: [id],
//         uri: uri
//       };
//
//       let fetchFileResult = await media.getFileAssets(mediaFetchOptions);
//       LogUtils.info(this.TAG, `fileList getFileAssetsFromType fetchFileResult.count = ${fetchFileResult.getCount()}`);
//       fileList = await fetchFileResult.getAllObject();
//       fetchFileResult.close();
//       await media.release();
//
//     } catch (e) {
//       LogUtils.info(this.TAG, "query: file data  exception ");
//     }
//
//     if (fileList && fileList.length > 0) {
//
//       let fileInfoObj = fileList[0];
//       LogUtils.info(this.TAG, `file id = ${JSON.stringify(fileInfoObj.id)} , uri = ${JSON.stringify(fileInfoObj.uri)}`);
//       LogUtils.info(this.TAG,
//         `file fileList displayName = ${fileInfoObj.displayName} ,size = ${fileInfoObj.size} ,mimeType = ${fileInfoObj.mimeType}`);
//
//      // mediaBean.fileName = fileInfoObj.displayName;
//       mediaBean.fileSize = fileInfoObj.size;
//       mediaBean.fileType = fileInfoObj.mimeType;
//
//     }
//   }
// }

interface wantParam {
  uri: string,
  action: string
}
