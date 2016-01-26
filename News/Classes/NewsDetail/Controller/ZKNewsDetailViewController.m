//
//  ZKNewsDetailViewController.m
//  News
//
//  Created by tarena on 16/1/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZKNewsDetailViewController.h"

@interface ZKNewsDetailViewController ()<UIWebViewDelegate>

/** 设置背景图 */
@property (nonatomic, strong)UIImageView *backgroundImageView;
/** 设置webView用于显示新闻的具体内容 */
@property (nonatomic, strong)UIWebView *newsWebView;
/** 设置自定义的返回按钮 */
@property (nonatomic, strong)UIButton *backButton;
@end

@implementation ZKNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupBackgroundImageView];
    [self setupNewsWebView];
    [self setupBackButton];
    [self webViewLoadNewsDetail];
    
}

- (void)setupBackgroundImageView{
    self.backgroundImageView = [UIImageView new];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.backgroundImageView.image = [UIImage imageNamed:@"cover"];
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    
}

- (void)setupNewsWebView{
    self.newsWebView = [[UIWebView alloc]init];
    self.newsWebView.tintColor = [UIColor clearColor];
    self.newsWebView.delegate = self;
    [self.view addSubview:self.newsWebView];
    [self.newsWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(backMainController)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.newsWebView addGestureRecognizer:swipe];
}



- (void)webViewLoadNewsDetail{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.newsDetailURLStr]];
    [self.newsWebView loadRequest:request];
}

- (void)setupBackButton{
    self.backButton = [UIButton buttonWithType:0];
    [self.view addSubview:self.backButton];
    [self.backButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [self.backButton setImage:[UIImage imageNamed:@"icon_back_highlighted"] forState:UIControlStateHighlighted];
    self.backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.left.mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(50, 40));
    }];
    [self.backButton addTarget:self action:@selector(backMainController) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backMainController{
    self.newsWebView = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
