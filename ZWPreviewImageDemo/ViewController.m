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
    for (NSInteger i=0; i<10; i++) {
        [mutArray addObject:@"http://api.nfboyin.com/dinggu/upload/lunbo1.png"];
    }
    ZWPhotoPreview *view = [ZWPhotoPreview zw_showPhotoPreview];
    view.photoDatas = [ZWPhotoPreviewDataModel transformPhotoURLArray:mutArray];
    view.showIndex = 30;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
