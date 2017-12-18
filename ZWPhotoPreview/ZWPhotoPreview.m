//
//  ZWPhotoPreview.m
//  ZWPreviewImageDemo
//
//  Created by 王子武 on 2017/12/14.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import "ZWPhotoPreview.h"
#import "ZWPhotoPreviewCell.h"
@interface ZWPhotoPreview ()
<UICollectionViewDelegate,
UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *mCollection;
@property (nonatomic, strong) UIImageView *maskImageView;
@property (nonatomic, strong) UILabel *pageLabel;
@property (nonatomic, strong) UIButton *pageBtn;
@property (nonatomic, strong) UIScrollView *mScroll;
@property (nonatomic, strong) UILabel *photoTitleLab;
@property (nonatomic, strong) UILabel *photoDescLab;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UILabel *tips;
@end
@implementation ZWPhotoPreview
@synthesize previewConfig = _previewConfig;
-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        [self configDefaultUI];
    }
    return self;
}
#pragma mark - config
- (void)configDefaultUI {
    self.backgroundColor = [UIColor blackColor];
    [self configCollection];
    [self configPanGesture];
}
- (void)configCollection {
    [self addSubview:self.mCollection];
}
- (void)configPanGesture {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(actionPan:)];
    [self addGestureRecognizer:panGesture];
    self.panGesture = panGesture;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(actionLongPress:)];
    [self addGestureRecognizer:longPress];
    
}
#pragma mark - lifeCycle
#pragma mark - delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photoDatas.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZWPhotoPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZWPhotoPreviewCell"
                                                                         forIndexPath:indexPath];
    ZWPhotoPreviewDataModel *model = self.photoDatas[indexPath.row];
    cell.cellModel = model;
    cell.previewConfig = self.previewConfig;
    cell.blockActionSingleTap = ^{
        [self hiddenViewAniamtion];
    };
    return cell;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat page = self.mCollection.contentOffset.x/CGRectGetWidth(self.bounds);
    self.showIndex = page;
}
#pragma mark - actionFunction
- (void)actionPan:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    CGFloat alpha = 1 - fabs(translation.y/CGRectGetHeight(self.bounds) * 2);
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            [self handlePanFollowImageViewIndex:self.showIndex];
            self.mCollection.hidden = YES;
            self.maskImageView.hidden = NO;
        }
            break;
        case UIGestureRecognizerStateChanged: {
            self.maskImageView.center = CGPointMake(CGRectGetMidX(self.bounds) + translation.x,
                                                    CGRectGetMidY(self.bounds) + translation.y);
            self.maskImageView.transform = CGAffineTransformMakeScale(alpha, alpha);
            self.alpha = alpha;
        }
            break;
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            if (alpha>self.previewConfig.dismissMaxScale) {
                self.maskImageView.transform = CGAffineTransformIdentity;
                self.mCollection.hidden = NO;
                self.maskImageView.hidden = YES;
                self.alpha = 1;
            }else{
                [self hiddenViewAniamtion];
            }
        }
            break;
        default:
            break;
    }
}
- (void)actionLongPress:(UILongPressGestureRecognizer *)gesture {
    if (self.previewConfig.forbidLongPressSavePhoto) {
        return;
    }
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self showActionSheet];
    }
}
#pragma mark - function
- (void)showActionSheet {
    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存到手机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //将图片保存到相册
        UIImageWriteToSavedPhotosAlbum([self handleShowImageView:self.showIndex], self, @selector(saveImage:finishError:contextInfo:), NULL);
    }];
    [alertCtr addAction:cancleAction];
    [alertCtr addAction:saveAction];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = self;
    [vc presentViewController:alertCtr animated:YES completion:nil];
}
- (void)saveImage:(UIImage *) image finishError: (NSError *) error contextInfo:(void *)contextInfo{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"图片已保存到相册" ;
    }
    [self showTips:msg];
}
- (void)showTips:(NSString *)tips {
    self.tips.alpha = 1;
    self.tips.hidden = NO;
    self.tips.text = tips;
    [UIView animateWithDuration:2 animations:^{
        self.tips.alpha = 0;
    } completion:^(BOOL finished) {
        self.tips.hidden = YES;
    }];
}
- (void)handlePanFollowImageViewIndex:(NSInteger)index {
    ZWPhotoPreviewCell *cell = (ZWPhotoPreviewCell *)[self.mCollection cellForItemAtIndexPath:
                                                      [NSIndexPath indexPathForItem:index inSection:0]];
    self.maskImageView.frame = cell.photoImageView.frame;
    self.maskImageView.transform = CGAffineTransformIdentity;
    self.maskImageView.image = cell.photoImageView.image;
    self.maskImageView.hidden = YES;
}
- (UIImage *)handleShowImageView:(NSInteger)index {
    ZWPhotoPreviewCell *cell = (ZWPhotoPreviewCell *)[self.mCollection cellForItemAtIndexPath:
                                                      [NSIndexPath indexPathForItem:index inSection:0]];
    UIImage *image = cell.photoImageView.image;
    return image;
}
- (void)hiddenViewAniamtion {
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)changeIndexPageNum:(NSInteger)indexPage{
    NSString *currPageStr = [NSString stringWithFormat:@"%ld",(long)indexPage + 1];
    NSString *totalPageStr = [NSString stringWithFormat:@"%lu",(unsigned long)self.photoDatas.count];
    self.pageLabel.text = [NSString stringWithFormat:@"%@/%@",currPageStr,totalPageStr];
    [self handlePageLabelSize];
}
- (void)handlePageLabelSize {
    [self.pageLabel sizeToFit];
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size.width = CGRectGetWidth(self.pageLabel.bounds) + 10;
    frame.size.height = frame.size.width;
    frame.origin.x = CGRectGetWidth(self.bounds) - frame.size.width - 10;
    frame.origin.y = CGRectGetHeight(self.bounds) - frame.size.height - 10;
    self.pageLabel.frame = frame;
    self.pageLabel.layer.cornerRadius = frame.size.width/2;
}
- (void)handleRemarkInfo:(NSInteger)indexPage {
    ZWPhotoPreviewDataModel *model = self.photoDatas[indexPage];
    self.photoTitleLab.font = [UIFont systemFontOfSize:self.previewConfig.photoTitleFontSize];
    self.photoDescLab.font = [UIFont systemFontOfSize:self.previewConfig.photoDescFontSize];
    self.photoTitleLab.frame = CGRectMake(0, 0, CGRectGetWidth(self.mScroll.frame), 0);
    self.photoTitleLab.text = model.zw_photoTitle;
    [self.photoTitleLab sizeToFit];
    
    self.photoDescLab.frame = CGRectMake(0, CGRectGetMaxY(self.photoTitleLab.frame)+10,
                                         CGRectGetWidth(self.mScroll.frame), 0);
    self.photoDescLab.text = model.zw_photoDesc;
    [self.photoDescLab sizeToFit];
    
    self.mScroll.contentSize = CGSizeMake(1, CGRectGetMaxY(self.photoDescLab.frame));
}
- (void)handlePreviewConfig {
    if (self.previewConfig.forbidPanDismiss) {
        [self removeGestureRecognizer:self.panGesture];
    }
    self.photoTitleLab.font = [UIFont systemFontOfSize:self.previewConfig.photoTitleFontSize];
    self.photoDescLab.font = [UIFont systemFontOfSize:self.previewConfig.photoDescFontSize];
    [self handleRemarkInfo:self.showIndex];
    [self.mCollection reloadData];
}
#pragma mark - ExportAPI
/**
 *  show in window
 */
+ (instancetype)zw_showPhotoPreview {
    return [self zw_showPhotoPreview:nil];
}
+ (instancetype)zw_showPhotoPreview:(NSArray <ZWPhotoPreviewDataModel *>*)photoDatas {
    ZWPhotoPreview *view = [[ZWPhotoPreview alloc] init];
    view.photoDatas = photoDatas;
    [[[[UIApplication sharedApplication] delegate] window] addSubview:view];
    return view;
}
#pragma mark - layzing
-(void)setShowIndex:(NSInteger)showIndex{
    _showIndex = showIndex;
    [self changeIndexPageNum:showIndex];
    [self handleRemarkInfo:showIndex];
    [_mCollection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:showIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}
- (void)setPhotoDatas:(NSArray<ZWPhotoPreviewDataModel *> *)photoDatas {
    _photoDatas = photoDatas;
    [self changeIndexPageNum:0];
    [self handleRemarkInfo:0];
}
- (UICollectionView *)mCollection{
    if (!_mCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.itemSize = self.bounds.size;
        _mCollection = [[UICollectionView alloc] initWithFrame:self.bounds
                                          collectionViewLayout:layout];
        [_mCollection registerClass:[ZWPhotoPreviewCell class]
         forCellWithReuseIdentifier:NSStringFromClass([ZWPhotoPreviewCell class])];
        _mCollection.dataSource = self;
        _mCollection.delegate = self;
        _mCollection.pagingEnabled = YES;
    }
    return _mCollection;
}
- (UILabel *)pageLabel{
    if (!_pageLabel) {
        _pageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _pageLabel.textAlignment = NSTextAlignmentCenter;
        _pageLabel.font = [UIFont systemFontOfSize:15];
        _pageLabel.textColor = [UIColor whiteColor];
        _pageLabel.backgroundColor = [UIColor darkGrayColor];
        _pageLabel.clipsToBounds = YES;
        [self addSubview:_pageLabel];
    }
    return _pageLabel;
}
- (UIImageView *)maskImageView {
    if (!_maskImageView) {
        _maskImageView = [[UIImageView alloc] init];
        _maskImageView.hidden = YES;
        [self addSubview:_maskImageView];
    }
    return _maskImageView;
}
- (ZWPhotoPreviewConfig *)previewConfig {
    if (!_previewConfig) {
        _previewConfig = [[ZWPhotoPreviewConfig alloc] init];
    }
    return _previewConfig;
}
- (void)setPreviewConfig:(ZWPhotoPreviewConfig *)previewConfig {
    _previewConfig = previewConfig;
    [self handlePreviewConfig];
}
- (UIScrollView *)mScroll {
    if (!_mScroll) {
        _mScroll = [[UIScrollView alloc] init];
        _mScroll.frame = CGRectMake(20, CGRectGetHeight(self.bounds)-120, CGRectGetWidth(self.bounds)-80, 100);
        _mScroll.backgroundColor = [UIColor clearColor];
        _mScroll.clipsToBounds = NO;
        [self addSubview:_mScroll];
    }
    return _mScroll;
}
- (UILabel *)photoTitleLab {
    if (!_photoTitleLab) {
        _photoTitleLab = [[UILabel alloc] init];
        _photoTitleLab.textColor = [UIColor whiteColor];
        _photoTitleLab.numberOfLines = 0;
        [self.mScroll addSubview:_photoTitleLab];
    }
    return _photoTitleLab;
}
- (UILabel *)photoDescLab {
    if (!_photoDescLab) {
        _photoDescLab = [[UILabel alloc] init];
        _photoDescLab.textColor = [UIColor whiteColor];
        _photoDescLab.numberOfLines = 0;
        [self.mScroll addSubview:_photoDescLab];
    }
    return _photoDescLab;
}
- (UIButton *)pageBtn {
    if (!_pageBtn) {
        _pageBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    return _pageBtn;
}
- (UILabel *)tips {
    if (!_tips) {
        _tips = [[UILabel alloc] init];
        _tips.textAlignment = NSTextAlignmentCenter;
        _tips.frame = CGRectMake(0, 0, 200, 40);
        _tips.center = self.center;
        _tips.layer.cornerRadius = 5;
        _tips.clipsToBounds = YES;
        _tips.textColor = [UIColor whiteColor];
        _tips.backgroundColor = [UIColor blackColor];
        _tips.hidden = YES;
        [self addSubview:_tips];
    }
    return _tips;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
