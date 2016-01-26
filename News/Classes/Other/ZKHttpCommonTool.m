//
//  ZKHttpCommonTool.m
//  News
//
//  Created by tarena on 16/1/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZKHttpCommonTool.h"

@implementation ZKHttpCommonTool

+(instancetype)sharedHttpCommontTool{
    
    static ZKHttpCommonTool *htc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",NEWSLISTURL]];
        NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
        htc = [[self alloc]initWithBaseURL:url sessionConfiguration:config];
        
        htc.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return htc;
}
@end
