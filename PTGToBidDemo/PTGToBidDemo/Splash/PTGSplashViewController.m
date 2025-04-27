//
//  PTGToBidSplashViewController.m
//  PTGSDKDemo
//
//  Created by yongjiu on 2025/4/15.
//

#import "PTGSplashViewController.h"
#import <WindMillSDK/WindMillSDK.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

@interface PTGSplashViewController ()<WindMillSplashAdDelegate>

@property (nonatomic,assign) BOOL isLoading;
@property (nonatomic, strong) WindMillSplashAd *splashAd;

@end

@implementation PTGSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
//

- (void)loadAd:(UIButton *)sender {
    if (self.isLoading) {
        return;
    }
    self.isLoading = YES;
    self.statusLabel.text = @"广告加载中";
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 80)];
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SplashLogo"]];
    logo.accessibilityIdentifier = @"splash_logo";
    logo.frame = CGRectMake(0, 0, 311, 47);
    logo.center = bottomView.center;
    [bottomView addSubview:logo];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.splashAd loadAdAndShowWithBottomView:bottomView];
}


- (void)showAd:(UIButton *)sender {

    [self.splashAd showAdInWindow:self.view.window withBottomView:nil];
}


#pragma mark - WindMillSplashAdDelegate
- (void)onSplashAdDidLoad:(WindMillSplashAd *)splashAd {
    self.isLoading = NO;
    self.statusLabel.text = @"广告加载成功";
    NSLog(@"开屏加载成功%@ -- %@", NSStringFromSelector(_cmd), splashAd.placementId);
}

- (void)onSplashAdLoadFail:(WindMillSplashAd *)splashAd error:(NSError *)error {
    NSLog(@"开屏加载失败%@ -- %@ error = %@", NSStringFromSelector(_cmd), splashAd.placementId,error);
    self.isLoading = NO;
    self.statusLabel.text = @"广告加载失败";
    self.splashAd.delegate = nil;
    self.splashAd = nil;
    
}

- (void)onSplashAdSuccessPresentScreen:(WindMillSplashAd *)splashAd {
    NSLog(@"开屏曝光%@ -- %@", NSStringFromSelector(_cmd), splashAd.placementId);
}

- (void)onSplashAdFailToPresent:(WindMillSplashAd *)splashAd withError:(NSError *)error {
    NSLog(@"%@ -- %@", NSStringFromSelector(_cmd), splashAd.placementId);
    NSLog(@"%@", error);
    self.splashAd.delegate = nil;
    self.splashAd = nil;
}

- (void)onSplashAdClicked:(WindMillSplashAd *)splashAd {
    NSLog(@"开屏点击%@ -- %@", NSStringFromSelector(_cmd), splashAd.placementId);
}

- (void)onSplashAdSkiped:(WindMillSplashAd *)splashAd {
    NSLog(@"开屏跳过%@ -- %@", NSStringFromSelector(_cmd), splashAd.placementId);
}

- (void)onSplashAdWillClosed:(WindMillSplashAd *)splashAd {
    NSLog(@"开屏将要关闭%@ -- %@", NSStringFromSelector(_cmd), splashAd.placementId);
}

- (void)onSplashAdClosed:(WindMillSplashAd *)splashAd {
    NSLog(@"开屏关闭%@ -- %@", NSStringFromSelector(_cmd), splashAd.placementId);
}

- (void)onSplashZoomOutViewAdDidClick:(WindMillSplashAd *)splashAd {
    NSLog(@"%@ -- %@", NSStringFromSelector(_cmd), splashAd.placementId);
}

- (void)onSplashZoomOutViewAdDidClose:(WindMillSplashAd *)splashAd {
    NSLog(@"%@ -- %@", NSStringFromSelector(_cmd), splashAd.placementId);
    self.splashAd.delegate = nil;
    self.splashAd = nil;
}

- (void)onSplashAdDidCloseOtherControllerWithInteractionType:(WindMillInteractionType)interactionType {
    
}

- (WindMillSplashAd *)splashAd {
    if (!_splashAd) {
        WindMillAdRequest *request = [WindMillAdRequest request];
        request.placementId = @"8527222611511637";
        _splashAd = [[WindMillSplashAd alloc] initWithRequest:request extra:nil];
        _splashAd.rootViewController = self;
        _splashAd.delegate = self;
    }
    return _splashAd;
}

@end
