//
//  PTGToBidSplashViewController.m
//  PTGSDKDemo
//
//  Created by yongjiu on 2025/4/15.
//

#import "PTGToBidSplashViewController.h"
#import <WindMillSDK/WindMillSDK.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

@interface PTGToBidSplashViewController ()<WindMillSplashAdDelegate>

@property (nonatomic, strong) WindMillSplashAd *splashAd;

@end

@implementation PTGToBidSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
//

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            switch (status) {
                case ATTrackingManagerAuthorizationStatusAuthorized:
                {
                    NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
                    NSLog(@"idfa = %@",idfa);
                }
                    break;
                default:
            }
        }];
    } else {
    }
}

- (void)confirm:(UIButton *)sender {
    [self loadAd];
}

- (void)loadAd {
    [self.splashAd loadAdAndShow];
}

#pragma mark - WindMillSplashAdDelegate
- (void)onSplashAdDidLoad:(WindMillSplashAd *)splashAd {
    NSLog(@"开屏加载成功%@ -- %@", NSStringFromSelector(_cmd), splashAd.placementId);
}

- (void)onSplashAdLoadFail:(WindMillSplashAd *)splashAd error:(NSError *)error {
    NSLog(@"开屏加载失败%@ -- %@", NSStringFromSelector(_cmd), splashAd.placementId);
    NSLog(@"%@", error);
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
        request.placementId = @"8887331548691742";
        _splashAd = [[WindMillSplashAd alloc] initWithRequest:request extra:nil];
        _splashAd.rootViewController = self;
        _splashAd.delegate = self;
    }
    return _splashAd;
}

@end
