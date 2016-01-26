//
//  ZKHttpTool.m
//  News
//
//  Created by tarena on 16/1/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZKHttpTool.h"
#import "ZKDataCacheTool.h"
#import "ZKHttpCommonTool.h"
@implementation ZKHttpTool

+(void)getWithUrl:(NSString *)str parms:(NSDictionary *)parms idStr:(NSString *)idStr networkCount:(int)networkCount success:(void (^)(id))success failture:(void (^)(id))failture{
    //  查找数据库
    if (idStr.length > 0 && networkCount <= 1) {
        NSArray *arr = [ZKDataCacheTool dataWithID:idStr];
        if (arr.count > 0) {
            success(arr);
            return;
        }
    }
    [[ZKHttpCommonTool sharedHttpCommontTool] GET:str parameters:parms success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *key = [dic.keyEnumerator nextObject];
        NSArray *newsArr = dic[key];
        
        if (idStr.length > 0) {
            [ZKDataCacheTool deleteWithID:idStr];
            [ZKDataCacheTool addArr:newsArr andID:idStr];
        }
        if (success) {
            success(newsArr);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failture) {
            failture(error);
        }
    }];
}
@end
