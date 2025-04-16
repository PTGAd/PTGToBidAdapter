//
//  AppDelegate.m
//  PTGToBidDemo
//
//  Created by yongjiu on 2025/4/15.
//

#import "AppDelegate.h"
#import <WindMillSDK/WindMillSDK.h>
#import "PTGToBidSplashViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyWindow];
    [WindMillAds setupSDKWithAppId:@"43492"];
    self.window.rootViewController = [[PTGToBidSplashViewController alloc] init];
    return YES;
}


@end
