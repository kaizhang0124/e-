//
//  ZKHttpTool.h
//  News
//
//  Created by tarena on 16/1/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^success) (id json);
typedef void (^failture) (id error);

@interface ZKHttpTool : NSObject
+ (void)getWithUrl:(NSString*)str parms:(NSDictionary*)parms  idStr:(NSString*)idStr networkCount:(int)networkCount success:(void(^)(id json))success failture:(void(^)(id error))failture;

+ (void)getDetailWithUrl: (NSString *)str parms: (NSDictionary *)parms success:(success)success failture:(failture)failture;
@end
