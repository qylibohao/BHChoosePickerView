//
//  ViewController.m
//  BHChoosePickerView
//
//  Created by libohao on 15/8/13.
//  Copyright (c) 2015年 libohao. All rights reserved.
//

#import "ViewController.h"
#import "CMFanPickerCollectionView.h"
#import "CMFanPickerFlowLayout.h"
#import "CMFanPickerCollectionViewCell.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
NSString *CollectionViewCellReuseIdentifier = @"CollectionViewCellReuseIdentifier";


@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,CMFanPickerCollectionViewCellDelegate>
{
    BOOL dragEnable;
}
@property (nonatomic, strong) UIImageView* cirCleBackGroundView;
@property (nonatomic, strong) UIImageView* matchAvatarView;

@property (nonatomic, strong) UIImageView* dragMaskView;

@property (nonatomic, strong) CMFanPickerCollectionView *selectionCollectionView;
@property (nonatomic, strong) CMFanPickerFlowLayout* defaultLayout;

@end

@implementation ViewController

#pragma markt - Property

- (UIImageView* )matchAvatarView {
    if (!_matchAvatarView) {
        _matchAvatarView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 30, SCREEN_WIDTH - 10,SCREEN_WIDTH - 10)];
        _matchAvatarView.layer.cornerRadius = CGRectGetWidth(_matchAvatarView.frame)/2;
        _matchAvatarView.layer.masksToBounds = YES;
        //_matchAvatarView.backgroundColor = [[UIColor yellowColor]colorWithAlphaComponent:0.3];
    }
    return _matchAvatarView;
}

- (UIImageView* )dragMaskView {
    if (!_dragMaskView) {
        CGFloat wid = self.defaultLayout.itemSize.width * self.defaultLayout.zoomFactor;
        _dragMaskView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, wid, wid)];
        _dragMaskView.hidden = YES;
        _dragMaskView.layer.cornerRadius = CGRectGetWidth(_dragMaskView.frame)/2;
        _dragMaskView.layer.masksToBounds = YES;
    }
    return _dragMaskView;
}

- (UIImageView* )cirCleBackGroundView {
    if (!_cirCleBackGroundView) {
        _cirCleBackGroundView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 30, SCREEN_WIDTH - 10,SCREEN_WIDTH - 10)];
        _cirCleBackGroundView.layer.cornerRadius = CGRectGetWidth(_cirCleBackGroundView.frame)/2;
        _cirCleBackGroundView.layer.borderWidth = 17;
        _cirCleBackGroundView.center = CGPointMake(self.view.center.x, _cirCleBackGroundView.center.y);
        _cirCleBackGroundView.layer.borderColor = [UIColor blackColor].CGColor;
        _cirCleBackGroundView.layer.masksToBounds = YES;
    }
    return _cirCleBackGroundView;
}

- (UICollectionView* )selectionCollectionView {
    if (!_selectionCollectionView) {
        _selectionCollectionView = [[CMFanPickerCollectionView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 210, SCREEN_WIDTH, 160) collectionViewLayout:[CMFanPickerFlowLayout PickerFlowLayout]];
        _selectionCollectionView.backgroundColor = [UIColor clearColor];
        [_selectionCollectionView setCollectionViewLayout:self.defaultLayout];
        [_selectionCollectionView setShowsHorizontalScrollIndicator:NO];
        CGFloat wid = self.defaultLayout.itemSize.width;
        [_selectionCollectionView setContentInset:UIEdgeInsetsMake(0, SCREEN_WIDTH/2 - wid/2 , 0, SCREEN_WIDTH/2 - wid/2)];
        _selectionCollectionView.delegate = self;
        _selectionCollectionView.dataSource = self;
        [_selectionCollectionView registerClass:[CMFanPickerCollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellReuseIdentifier];
    }
    return _selectionCollectionView;
}

- (CMFanPickerFlowLayout* )defaultLayout {
    if (!_defaultLayout) {
        _defaultLayout = [CMFanPickerFlowLayout PickerFlowLayout];
    }
    return _defaultLayout;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.cirCleBackGroundView];
    [self.view addSubview:self.matchAvatarView];
    [self.view addSubview:self.selectionCollectionView];
    [self.view addSubview:self.dragMaskView];
}

- (void)viewDidAppear:(BOOL)animated {
    dragEnable = YES;

    [self configMidCellPanEnable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionView Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CMFanPickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellReuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    NSString* imgName = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imgName];
    return cell;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"begin");
    dragEnable = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"end");
    dragEnable = YES;
    
    [self configMidCellPanEnable];
}

- (void)configMidCellPanEnable {
    CGFloat scale = 1.0;
    CMFanPickerCollectionViewCell* midCell;
    for (CMFanPickerCollectionViewCell *cell in self.selectionCollectionView.visibleCells) {
        cell.panEnable = NO;
        CATransform3D transform =  cell.layer.transform;
        if (transform.m11 > scale) {
            scale = transform.m11;
            midCell = cell;
        }
    }
    
    midCell.panEnable = YES;
    
}

#pragma mark - CMFanPickerCollectionViewCellDelegate

- (void)CellDidPan:(UIPanGestureRecognizer*) recognizer{
    if (!dragEnable)
        return;
    
    CGPoint translation = [recognizer translationInView:self.view];
    UIImageView* originImageView = (UIImageView*)recognizer.view;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        //UIImage* roundImage = [UIImage createRoundedRectImage:originImageView.image size:originImageView.image.size roundRadius:CGRectGetWidth(self.dragMaskView.frame)/2];
        self.dragMaskView.image = originImageView.image;
        
    }else if(recognizer.state == UIGestureRecognizerStateChanged) {
        self.dragMaskView.hidden = NO;
        CGPoint imageCenter = [self.view convertPoint:originImageView.center fromView:originImageView];
        self.dragMaskView.center = CGPointMake(imageCenter.x + translation.x,
                                               imageCenter.y + translation.y);
    }else if (recognizer.state == UIGestureRecognizerStateEnded ){
        NSLog(@"end");
        self.dragMaskView.hidden = YES;
        if ( [self distanceFromPointX:self.dragMaskView.center distanceToPointY:self.cirCleBackGroundView.center] < CGRectGetWidth(self.cirCleBackGroundView.frame)/2) {
            
             self.matchAvatarView.image = self.dragMaskView.image;
            self.matchAvatarView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.matchAvatarView.transform = CGAffineTransformMakeScale(1, 1);
            } completion:nil];
        }
    }
}

-(float)distanceFromPointX:(CGPoint)start distanceToPointY:(CGPoint)end{
    float distance;
    CGFloat xDist = (end.x - start.x);
    CGFloat yDist = (end.y - start.y);
    distance = sqrt((xDist * xDist) + (yDist * yDist));
    return distance;
}


@end
