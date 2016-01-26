//
//  ZKLeftMenuViewController.m
//  News
//
//  Created by tarena on 16/1/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZKLeftMenuViewController.h"
#import "ZKNewsListViewController.h"
//#import "ZKFoodViewController.h"
#import "ZKWeChatViewController.h"
@interface ZKLeftMenuViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@end

@implementation ZKLeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * 5) / 2.0f, self.view.frame.size.width, 54 * 5) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView;
    });
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"新闻速递";
            cell.imageView.image = [UIImage imageNamed:@"sidebar_nav_radio"];
            break;
        case 1:
            cell.textLabel.text = @"微信精选";
            cell.imageView.image = [UIImage imageNamed:@"sidebar_nav_reading"];
            break;
        case 2:
            cell.textLabel.text = @"未确定功能";
            cell.imageView.image = [UIImage imageNamed:@"tabbar_icon_news_normal"];
            break;
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 设置cell不显示选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ZKNewsListViewController alloc] init]] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
        case 1:{
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ZKWeChatViewController alloc] init]] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
        default:
            break;
    }
}
@end
