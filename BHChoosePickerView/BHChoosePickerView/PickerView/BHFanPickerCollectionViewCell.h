//
//  CMFanCollectionViewCell
//  Chimian
//
//  Created by libohao on 15/6/24.
//
//

#import <UIKit/UIKit.h>

@protocol BHFanPickerCollectionViewCellDelegate <NSObject>

- (void)CellDidPan:(UIPanGestureRecognizer*) recognizer;

@end

@interface BHFanPickerCollectionViewCell : UICollectionViewCell


@property (nonatomic, assign) id<BHFanPickerCollectionViewCellDelegate> delegate;

@property (nonatomic, assign) BOOL panEnable;

@property (nonatomic, strong) UIImageView* imageView;

@end
