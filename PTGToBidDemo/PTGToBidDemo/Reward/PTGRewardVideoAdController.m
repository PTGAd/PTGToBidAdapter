//
//  PTGSplashViewController 2.h
//  PTGToBidDemo
//
//  Created by yongjiu on 2025/6/16.
//


//
//  PTGToBidSplashViewController.m
//  PTGSDKDemo
//
//  Created by yongjiu on 2025/4/15.
//

#import "PTGRewardVideoAdController.h"
#import <WindMillSDK/WindMillSDK.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

@interface PTGRewardVideoAdController ()<WindMillRewardVideoAdDelegate>

@property (nonatomic,assign) BOOL isLoading;
@property (nonatomic, strong) WindMillRewardVideoAd *rewardVideoAd;

@end

@implementation PTGRewardVideoAdController

- (void)viewDidLoad {
    [super viewDidLoad];
    WindMillAdRequest *request = [WindMillAdRequest request];
    request.userId = @"12345";
    request.rewardName = @"哈哈哈";
    request.rewardAmount = 200;
    request.placementId = @"8337164384653689";
    _rewardVideoAd = [[WindMillRewardVideoAd alloc] initWithRequest:request];
    _rewardVideoAd.delegate = self;

}
//

- (void)loadAd:(UIButton *)sender {
    if (self.isLoading) {
        return;
    }
    self.isLoading = YES;
    self.statusLabel.text = @"广告加载中";
    [self.rewardVideoAd loadAdData];
}


- (void)showAd:(UIButton *)sender {
    if (!self.rewardVideoAd.isAdReady) {
        self.statusLabel.text = @"广告已过期";
        return;
    }

    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 80)];
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SplashLogo"]];
    logo.accessibilityIdentifier = @"splash_logo";
    logo.frame = CGRectMake(0, 0, 311, 47);
    logo.center = bottomView.center;
    [bottomView addSubview:logo];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.rewardVideoAd showAdFromRootViewController:self options:nil];
    self.statusLabel.text = @"广告展示中";
}


#pragma mark - WindMillRewardVideoAdDelegate -
- (void)rewardVideoAdDidLoad:(WindMillRewardVideoAd *)rewardVideoAd {
    self.isLoading = NO;
    self.statusLabel.text = @"广告加载成功";
    NSLog(@"激励加载成功%@ -- %@", NSStringFromSelector(_cmd), rewardVideoAd.placementId);
}

- (void)rewardVideoAdDidLoad:(WindMillRewardVideoAd *)rewardVideoAd didFailWithError:(NSError *)error {
    NSLog(@"激励加载失败%@ -- %@ error = %@", NSStringFromSelector(_cmd), rewardVideoAd.placementId,error);
    self.isLoading = NO;
    self.statusLabel.text = @"广告加载失败";
    self.rewardVideoAd.delegate = nil;
    self.rewardVideoAd = nil;
}

- (void)rewardVideoAdWillVisible:(WindMillRewardVideoAd *)rewardVideoAd {
    NSLog(@"激励将要展示%@ -- %@", NSStringFromSelector(_cmd), rewardVideoAd.placementId);
}


- (void)rewardVideoAdDidVisible:(WindMillRewardVideoAd *)rewardVideoAd {
    NSLog(@"激励已经展示%@ -- %@", NSStringFromSelector(_cmd), rewardVideoAd.placementId);
}

- (void)rewardVideoAdDidShowFailed:(WindMillRewardVideoAd *)rewardVideoAd error:(NSError *_Nullable)error {
    NSLog(@"激励展示失败%@ -- %@", NSStringFromSelector(_cmd), rewardVideoAd.placementId);
}


- (void)rewardVideoAdDidClick:(WindMillRewardVideoAd *)rewardVideoAd {
    NSLog(@"激励%@ -- %@", NSStringFromSelector(_cmd), rewardVideoAd.placementId);
}

- (void)rewardVideoAdDidClickSkip:(WindMillRewardVideoAd *)rewardVideoAd {
    NSLog(@"激励%@ -- %@", NSStringFromSelector(_cmd), rewardVideoAd.placementId);
}

- (void)rewardVideoAd:(WindMillRewardVideoAd *)rewardVideoAd reward:(WindMillRewardInfo *)reward {
    NSLog(@"激励广告获得激励%@ -- %@", NSStringFromSelector(_cmd), rewardVideoAd.placementId);
}

- (void)rewardVideoAdDidClose:(WindMillRewardVideoAd *)rewardVideoAd {
    self.statusLabel.text = @"广告待加载";
    NSLog(@"激励关闭%@ -- %@", NSStringFromSelector(_cmd), rewardVideoAd.placementId);
}

- (void)rewardVideoAdDidPlayFinish:(WindMillRewardVideoAd *)rewardVideoAd didFailWithError:(NSError *)error {
    NSLog(@"激励播放完成%@ -- %@", NSStringFromSelector(_cmd), rewardVideoAd.placementId);
}



- (void)dealloc {
    self.rewardVideoAd.delegate = nil;
    self.rewardVideoAd = nil;
}



@end
