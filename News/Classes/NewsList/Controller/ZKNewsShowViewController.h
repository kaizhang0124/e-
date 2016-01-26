//
//  ZKNewsShowViewController.h
//  News
//
//  Created by tarena on 16/1/24.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKNewsShowViewController : UITableViewController
// 新闻分类的下表
@property (nonatomic,assign) NSInteger index;
// 新闻对应的URL
@property (nonatomic,copy) NSString *urlString;
@end
