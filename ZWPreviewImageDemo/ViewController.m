//
//  ViewController.m
//  ZWPreviewImageDemo
//
//  Created by 王子武 on 2017/6/8.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

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
        model2.zw_photoTitle = @"机会难得不如不得";
        model2.zw_photoDesc = @"机会难得不如不得机会难得不如不得机会难得不如不得";
        [mutArray addObject:model2];
    }
    [ZWPhotoPreview zw_showPhotoPreview:mutArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
