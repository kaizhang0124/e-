//
//  ZKDataManager.h
//  News
//
//  Created by tarena on 16/1/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZKNewsDetail.h"
@interface ZKDataManager : NSObject

+ (NSArray *)getNewsCategoryWithURLStr:(NSString *)urlStr;
+ (NSArray *)getNewsDetailWithNewsData:(NSData *)data;
+ (NSInteger)getTotalPageWithData:(NSData *)data;

@end
