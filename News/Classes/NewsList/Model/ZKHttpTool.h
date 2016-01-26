//
//  ZKHttpTool.h
//  News
//
//  Created by tarena on 16/1/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKHttpTool : NSObject
+ (void)getWithUrl:(NSString*)str parms:(NSDictionary*)parms  idStr:(NSString*)idStr networkCount:(int)networkCount success:(void(^)(id json))success failture:(void(^)(id error))failture;
@end
