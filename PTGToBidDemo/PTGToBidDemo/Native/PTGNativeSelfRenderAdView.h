//
//  PTGNativeSelfRenderAdView.h
//  PTGToBidDemo
//
//  Created by yongjiu on 2025/4/24.
//

#import <WindMillSDK/WindMillSDK.h>

NS_ASSUME_NONNULL_BEGIN
@class PTGNativeSelfRenderAdView;

@protocol PTGNativeSelfRenderAdViewDislikeDelgate <NSObject>

- (void)feedCustomDislike:(PTGNativeSelfRenderAdView *)nativeAdView;

@end


@interface PTGNativeSelfRenderAdView : WindMillNativeAdView

@property(nonatomic,weak)id<PTGNativeSelfRenderAdViewDislikeDelgate> dislikeDelegate;
+ (CGFloat)cellHeightWithModel:(WindMillNativeAd *_Nonnull)model width:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
