//
//  ZWPhotoPreviewConfig.h
//  ZWPreviewImageDemo
//
//  Created by 王子武 on 2017/12/15.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ZWPanDismissStyle) {
    //手势向上/向下滑动消失动画
    UpdownPandismissAnimation = 0,
    //手势-上滑消失动画
    UpPanDismissAnimation,
    //手势-下滑消失动画
    DownPanDismissAnimation,
    //禁止-手势滑动消失动画
    ForbidPanDismissAnimation
};

@interface ZWPhotoPreviewConfig : NSObject
/**
 *  图片放大倍数
 *  默认3.0f
 */
@property (nonatomic, assign) CGFloat maxZoomScale;
/**
 *  图片缩小倍数
 *  默认1.0f
 */
@property (nonatomic, assign) CGFloat minZoomScale;
/**
 *  手势拖动视图
 *  视图消失临界值
 *  默认0.80f
 */
@property (nonatomic, assign) CGFloat dismissMaxScale;
/**
 *  图片标题字体大小
 *  默认: 17
 */
@property (nonatomic, assign) CGFloat photoTitleFontSize;
/**
 *  图片文本字体大小
 *  默认: 13
 */
@property (nonatomic, assign) CGFloat photoDescFontSize;
/**
 *  禁止手势拖动隐藏视图动画
 *  默认“开启”手势动画
 */
@property (nonatomic, assign) BOOL forbidPanDismiss;
/**
 *  禁止长按保存图片
 *  默认“允许”
 */
@property (nonatomic, assign) BOOL forbidLongPressSavePhoto;
@end
