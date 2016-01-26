//
//  ZKDataCacheTool.h
//  News
//
//  Created by tarena on 16/1/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKDataCacheTool : NSObject

+ (void)addArr:(NSArray *)arr andID:(NSString *)idstr;
+ (void)addDict:(NSDictionary *)dict andID:(NSString *)idstr;
+ (NSArray*)dataWithID:(NSString*)ID;
+ (void)deleteWithID:(NSString *)ID;
@end
