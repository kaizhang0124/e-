//
//  ZKNewsShowViewController.m
//  News
//
//  Created by tarena on 16/1/24.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZKNewsShowViewController.h"
#import "ZKNewsDetailTableViewCell.h"
#import "ZKNewsModel.h"
#import "ZKHttpCommonTool.h"
#import "ZKHttpTool.h"
#import "ZKNewsDetailViewController.h"
@interface ZKNewsShowViewController ()
// 新闻列表
@property (nonatomic, strong)NSMutableArray *newsList;
// 判断是否刷新
@property (nonatomic, assign)BOOL update;
// 刷新次数
@property (nonatomic, assign)int updateCount;

@end

@implementation ZKNewsShowViewController

- (NSMutableArray *)newsList {
    if(_newsList == nil) {
        _newsList = [[NSMutableArray alloc] init];
    }
    return _newsList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZKNewsDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"newsCell"];
    self.update = YES;
    [self.tableView addHeaderWithTarget:self action:@selector(loadData)];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //开始刷新
    if (self.update == YES) {
        [self.tableView headerBeginRefreshing];
        self.update = NO;
    }
    
}
- (void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
}

- (void)loadData {
    self.updateCount++;
    NSString *url = [NSString stringWithFormat:@"/nc/article/%@/0-20.html",self.urlString];
    [self loadDataForType:1 withURL:url];
}

- (void)loadMoreData {
    NSString *url = [NSString stringWithFormat:@"/nc/article/%@/%d-20.html",self.urlString, (int)(self.newsList.count - self.newsList.count%10)];
    
    [self loadDataForType:2 withURL:url];
}

- (void)loadDataForType:(int)type withURL:(NSString *)url{
    NSString *idStr=nil;
    if(type==1){
        idStr=[[self.urlString componentsSeparatedByString:@"/"] lastObject];
    }
    
    [ZKHttpTool getWithUrl:url parms:nil idStr:idStr networkCount:self.updateCount success:^(id json) {
        NSArray *arrModel = [ZKNewsModel objectArrayWithKeyValuesArray:json];
//        NSLog(@"%@",arrModel);
        if (type == 1) {
            [self.newsList removeAllObjects];
            [self.newsList addObjectsFromArray:arrModel];
            [self.tableView headerEndRefreshing];
            [self.tableView reloadData];
        } else {
            [self.newsList addObjectsFromArray:arrModel];
            [self.tableView footerEndRefreshing];
            [self.tableView reloadData];
        }
        
    } failture:^(id error) {
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        NSLog(@"%@",error);
    }];
    
    
}

#pragma mark - UITableViewDelegate&dataSourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZKNewsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell"];
    ZKNewsModel *newsModel = self.newsList[indexPath.row];
    cell.newsTitleLabel.text = newsModel.title;
    cell.newsDescLabel.text = newsModel.digest;
    cell.newsDateLabel.text = newsModel.ptime;
    
    NSLog(@"%@",newsModel.url_3w);
    if (newsModel.imgsrc != nil) {
        [cell.newsHeadImageView sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc]];
    } else if (newsModel.imgextra != nil) {
        NSDictionary *dic = newsModel.imgextra.firstObject;
        NSString *imageUrlStr = dic[@"imgsrc"];
        [cell.newsHeadImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]];
        //        NSLog(@"%@",newsModel.imgextra);
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZKNewsModel *newsModel = self.newsList[indexPath.row];
    if (newsModel.url_3w != nil) {
        ZKNewsDetailViewController *vc = [ZKNewsDetailViewController new];
        vc.newsDetailURLStr = newsModel.url_3w;
        [self presentViewController:vc animated:YES completion:nil];
    }

}


@end
