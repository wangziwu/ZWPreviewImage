//
//  ZWPhotoPreviewDataModel.m
//  ZWPreviewImageDemo
//
//  Created by 王子武 on 2017/12/14.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import "ZWPhotoPreviewDataModel.h"

@implementation ZWPhotoPreviewDataModel
/**
 *  图片URL数组
 *  转换Model
 */
+ (NSArray <ZWPhotoPreviewDataModel *> *)transformPhotoURLArray:(NSArray *)urlArray {
    NSMutableArray *mutArray = [NSMutableArray array];
    [urlArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZWPhotoPreviewDataModel *model = [[ZWPhotoPreviewDataModel alloc] init];
        model.zw_photoURL = obj;
        [mutArray addObject:model];
    }];
    return mutArray;
}
@end
