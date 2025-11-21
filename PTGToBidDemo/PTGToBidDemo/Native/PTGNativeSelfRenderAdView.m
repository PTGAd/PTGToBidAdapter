//
//  PTGNativeSelfRenderAdView.m
//  PTGToBidDemo
//
//  Created by yongjiu on 2025/4/24.
//

#import "PTGNativeSelfRenderAdView.h"
#import <Masonry/Masonry.h>
#import "BUDFeedStyleHelper.h"

static CGFloat const margin = 15;
static CGSize const logoSize = {15, 15};
static UIEdgeInsets const padding = {10, 15, 10, 15};

@interface PTGNativeSelfRenderAdView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *customDislikeBtn;

@end

@implementation PTGNativeSelfRenderAdView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.customDislikeBtn];
    }
    return self;
}

- (void)closeButtonDidClicked:(UIButton *)sender {
    if ([self.dislikeDelegate respondsToSelector:@selector(feedCustomDislike:)]) {
        [self.dislikeDelegate feedCustomDislike:self];
    }
}

- (void)refreshData:(WindMillNativeAd *)nativeAd {
    [super refreshData:nativeAd];
    if (nativeAd.feedADMode == WindMillFeedADModeNativeExpress) { return; }

    CGFloat width = CGRectGetWidth(UIScreen.mainScreen.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;
    
    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:nativeAd.title];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    
    self.titleLabel.frame = CGRectMake(padding.left, y , contentWidth, titleSize.height);
    self.titleLabel.attributedText = attributedText;
    
    y += titleSize.height;
    y += 5;
    
    if (nativeAd.isVideoAd) {
        CGFloat videoHeight = contentWidth;
        AWMADImage *image = nativeAd.videoCoverImage;
        if (image.width > 0 && image.height > 0) {
            videoHeight = contentWidth * (image.height / image.width);
        }
        self.mediaView.frame = CGRectMake(padding.left, y, contentWidth, videoHeight);
        y += videoHeight;
    } else {
        CGFloat imageHeight = contentWidth;
        AWMADImage *image = nativeAd.imageModelList.firstObject;
        if (image.width > 0 && image.height > 0) {
            imageHeight = contentWidth * (image.height / image.width);
        }
        self.mainImageView.frame = CGRectMake(padding.left, y, contentWidth, imageHeight);
        y += imageHeight;
    }
    y += 10;
    
    /// logo宽高比 3 ： 1
    CGFloat originInfoX = padding.left;
    self.logoView.frame = CGRectMake(originInfoX,
                                             y + 3,
                                             42,
                                             14);
    
    /// 自定义视图，添加到canvasView 上
    CGFloat dislikeX = width - 20 - padding.right;
    [self addSubview:self.customDislikeBtn];
    self.customDislikeBtn.frame = CGRectMake(dislikeX, y, 20, 20);
    
    [self setClickableViews:@[self]];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

+ (CGFloat)cellHeightWithModel:(WindMillNativeAd *_Nonnull)model width:(CGFloat)width {
    if (!model || width <= 0) {
        return 0;
    }
    CGFloat contentWidth = (width - 2 * margin);
    NSAttributedString *attributedText = [BUDFeedStyleHelper titleAttributeText:model.title];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    
    CGFloat mediaH = 0;
    if (model.isVideoAd) {
        CGFloat videoHeight = contentWidth;
        AWMADImage *image = model.videoCoverImage;
        if (image.width > 0 && image.height > 0) {
            videoHeight = contentWidth * (image.height / image.width);
        }
        mediaH = videoHeight;
    } else {
        CGFloat imageHeight = contentWidth;
        AWMADImage *image = model.imageModelList.firstObject;
        if (image.width > 0 && image.height > 0) {
            imageHeight = contentWidth * (image.height / image.width);
        }
        mediaH = imageHeight;
    }
    return padding.top + titleSize.height + 5 + mediaH + 10 + 20 + padding.bottom;
}

- (UIButton *)customDislikeBtn {
    if (!_customDislikeBtn) {
        _customDislikeBtn = [[UIButton alloc] init];
        [_customDislikeBtn setImage:[UIImage imageNamed:@"closed"] forState:UIControlStateNormal];
        [_customDislikeBtn addTarget:self action:@selector(closeButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _customDislikeBtn;
}
@end
