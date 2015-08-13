//
//  CMFanCollectionViewCell
//  Chimian
//
//  Created by libohao on 15/6/24.
//
//

#import <UIKit/UIKit.h>

@protocol CMFanPickerCollectionViewCellDelegate <NSObject>

- (void)CellDidPan:(UIPanGestureRecognizer*) recognizer;

@end

@interface CMFanPickerCollectionViewCell : UICollectionViewCell


@property (nonatomic, assign) id<CMFanPickerCollectionViewCellDelegate> delegate;

@property (nonatomic, assign) BOOL panEnable;

@property (nonatomic, strong) UIImageView* imageView;

@end
