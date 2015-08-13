
#import "BHFanPickerCollectionViewCell.h"

@interface BHFanPickerCollectionViewCell()


@end

@implementation BHFanPickerCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.imageView];
        
    }
    return self;
}


- (UIImageView* )imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
        _imageView.image = [UIImage imageNamed:@"0.jpg"];
        _imageView.layer.cornerRadius = CGRectGetWidth(_imageView.frame)/2;
        _imageView.layer.masksToBounds = YES;
        _imageView.userInteractionEnabled = YES;
        UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        [_imageView addGestureRecognizer:pan];
        
    }
    return _imageView;
}

//- (void)setProfileItem:(CMProfileItem *)profileItem {
//    _profileItem = profileItem;
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:profileItem.avatar] placeholderImage:nil];
//}

- (void) handlePan:(UIPanGestureRecognizer*) recognizer {
    if ([_delegate respondsToSelector:@selector(CellDidPan:)]) {
        [_delegate CellDidPan:recognizer];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)setPanEnable:(BOOL)panEnable {
    _panEnable = panEnable;
    self.imageView.userInteractionEnabled = panEnable;
}
@end
