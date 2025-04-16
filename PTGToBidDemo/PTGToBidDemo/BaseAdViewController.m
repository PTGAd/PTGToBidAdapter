//
//  BaseAdViewController.m
//  PTGSDKDemo
//
//  Created byttt on 2024/10/27.
//

#import "BaseAdViewController.h"
#import "YYCategories/YYCategories.h"

@interface BaseAdViewController ()


@end

@implementation BaseAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textFiled.frame = CGRectMake(50, 100, 275, 30);
    self.shakeTextFiled.frame = CGRectMake(50, 150, 275, 30);
    self.confirmButton.frame = CGRectMake(100, UIScreen.mainScreen.bounds.size.height - 80, 175, 30);
    [self.view addSubview:self.textFiled];
    [self.view addSubview:self.shakeTextFiled];
    [self.view addSubview:self.confirmButton];
}

- (UITextField *)textFiled {
    if (!_textFiled) {
        _textFiled = [UITextField new];
        _textFiled.placeholder = @"请输入广告位id";
        _textFiled.borderStyle = UITextBorderStyleRoundedRect;
        _textFiled.font = [UIFont systemFontOfSize:14];
    }
    return _textFiled;
}

- (UITextField *)shakeTextFiled {
    if (!_shakeTextFiled) {
        _shakeTextFiled = [UITextField new];
        _shakeTextFiled.placeholder = @"摇一摇林敏度";
        _shakeTextFiled.borderStyle = UITextBorderStyleRoundedRect;
        _shakeTextFiled.keyboardType = UIKeyboardTypeNumberPad;
        _shakeTextFiled.font = [UIFont systemFontOfSize:14];
    }
    return _shakeTextFiled;
}


- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmButton setBackgroundImage:[UIImage imageWithColor:UIColor.grayColor size:CGSizeMake(175, 30)] forState:UIControlStateNormal];
    }
    return _confirmButton;
}

@end
