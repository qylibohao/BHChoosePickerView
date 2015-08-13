//
//  BHFanPickerCollectionView
//
//  Created by libohao on 15/8/5.
//
//

#import "BHFanPickerCollectionView.h"

@interface BHFanPickerCollectionView()<UIScrollViewDelegate>

@property (nonatomic, copy) void (^BackGroundTouchBlock)();


@end

@implementation BHFanPickerCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {

    }
    return self;
}


@end
