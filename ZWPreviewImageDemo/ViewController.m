//
//  ViewController.m
//  ZWPreviewImageDemo
//
//  Created by 王子武 on 2017/6/8.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//
/**
 *  email : wang_ziwu@126.com
 *  GitHub: <https://github.com/wangziwu/ZWPreviewImage>
 *  欢迎指正，如果对您有帮助、请记得Star哦！
 */
#import "ViewController.h"
#import "ZWPhotoPreview.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)showImage{
    NSMutableArray *mutArray = [NSMutableArray array];
    for (NSInteger i=0; i<3; i++) {
        ZWPhotoPreviewDataModel *model1 = [[ZWPhotoPreviewDataModel alloc] init];
        model1.zw_photoURL = @"http://api.nfboyin.com/dinggu/upload/lunbo1.png";
        model1.zw_photoTitle = @"春风十里不如你蠢";
        model1.zw_photoDesc = @"春风十里不如你蠢春风十里不如你蠢春风十里不如你蠢";
        [mutArray addObject:model1];
        
        ZWPhotoPreviewDataModel *model2 = [[ZWPhotoPreviewDataModel alloc] init];
        model2.zw_photoURL = @"http://api.nfboyin.com/dinggu/upload/lunbo2.png";
        model2.zw_photoTitle = @"机会难得得不到你";
        model2.zw_photoDesc = @"机会难得得不到你机会难得得不到你\n机会难得得不到你机会难得得不到你";
        [mutArray addObject:model2];
        
        ZWPhotoPreviewDataModel *model3 = [[ZWPhotoPreviewDataModel alloc] init];
        model3.zw_photoImage = [UIImage imageNamed:@"image1"];
        [mutArray addObject:model3];
    }
    [ZWPhotoPreview zw_showPhotoPreview:mutArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
