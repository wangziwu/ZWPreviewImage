//
//  ViewController.m
//  ZWPreviewImageDemo
//
//  Created by 王子武 on 2017/6/8.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import "ViewController.h"
#import "ZWPreviewImageView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)showImage{
    NSArray *array = @[@"http://api.nfboyin.com/dinggu/upload/lunbo1.png",
                       @"http://api.nfboyin.com/dinggu/upload/lunbo2.png"];
    ZWPreviewImageView *showView = [ZWPreviewImageView showImageWithArray:array withShowIndex:1];
    [showView showRootWindow];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
