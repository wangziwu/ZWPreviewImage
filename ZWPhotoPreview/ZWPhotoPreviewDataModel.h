//
//  ZWPhotoPreviewDataModel.h
//  ZWPreviewImageDemo
//
//  Created by 王子武 on 2017/12/14.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZWPhotoPreviewDataModel : NSObject
/**
 *  图片URL
 */
@property (nonatomic, copy) NSString *zw_photoURL;
/**
 *  图片
 */
@property (nonatomic, copy) UIImage *zw_photoImage;
/**
 *  图片标题
 */
@property (nonatomic, copy) NSString *zw_photoTitle;
/**
 *  图片描述
 */
@property (nonatomic, copy) NSString *zw_photoDesc;
/**
 *  图片URL/UIImage数组
 *  转换Model
 */
+ (NSArray <ZWPhotoPreviewDataModel *> *)transformPhotoURLArray:(NSArray *)urlArray;
@end
