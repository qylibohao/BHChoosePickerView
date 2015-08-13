//
//  CMFanPickerCollectionView.m
//  Chimian
//
//  Created by libohao on 15/8/5.
//
//

#import "CMFanPickerCollectionView.h"

@interface CMFanPickerCollectionView()<UIScrollViewDelegate>

@property (nonatomic, copy) void (^BackGroundTouchBlock)();


@end

@implementation CMFanPickerCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {

    }
    return self;
}


@end
