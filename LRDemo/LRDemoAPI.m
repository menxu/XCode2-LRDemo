//
//  LRDemoAPI.m
//  LRDemo
//
//  Created by menxu on 13-4-3.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import "LRDemoAPI.h"
#import "JSONKit.h"
#import "ASIHTTPRequest.h"


@implementation LRDemoAPI


//---------  异步加载 -----------------
+ (void)grabURLInBackground
{
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/api/blog_lists"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
//    [request setDidFailSelector:@selector(requestFailed:)];
//    [request setDidFinishSelector:@selector(requestFinished:)];
    [request startAsynchronous];
    
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
}

+ (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    NSLog ( @"----------------%@" ,responseString);
    
    // Use when fetching binary data
//    NSData *responseData = [request responseData];
}

+ (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",error);
}

+ (NSMutableArray *)getBlogList
{
    
//    [self grabURLInBackground];
    [self blockInBackground];
    return nil;
}

//---------  block块 -----------------
+ (void)blockInBackground
{
     NSURL *url = [NSURL URLWithString:@"http://localhost:3000/api/blog_lists"];
    
    __block ASIHTTPRequest *request = [ ASIHTTPRequest requestWithURL :url];
    
    // ASIHTTPRequest 支持 iOS 4.0 的块语法，你可以把委托方法定义到块中
    [request setCompletionBlock :^{
        // 请求响应结束，返回 responseString
        NSString *responseString = [request responseString ]; // 对于 2 进制数据，使用 NSData 返回 NSData *responseData = [request responseData];
        NSLog ( @"%@" ,responseString);
        [self get_by_json_blogLists:responseString];
    }];
    
    [request setFailedBlock :^{
        // 请求响应失败，返回错误信息
        NSError *error = [request error ];
        NSLog ( @"error:%@" ,[error userInfo ]); 
    }];
    
    [request startAsynchronous ];
}
+ (NSMutableArray *)get_by_json_blogLists:(NSString *)json_str{
    
    NSData *data=[json_str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *arr=(NSDictionary *)[data mutableObjectFromJSONData];
    
    NSArray *blogs = [arr objectForKey:@"blog_lists"];
       
    NSLog(@"count=%d",blogs.count);
    
    NSMutableArray *blog_lists = [[NSMutableArray alloc] init];

    for(int i=0;i<blogs.count;i++)
        
    {
        NSDictionary *blog=[blogs objectAtIndex:i];
        
        NSNumber *category_id=[blog objectForKey:@"category_id"];
        
        NSString *content=[blog objectForKey:@"content"];
        
        NSString *id=[blog objectForKey:@"id"];

        NSString *title=[blog objectForKey:@"title"];
       
        NSString *user_id = [blog objectForKey:@"user_id"];
        
        NSLog(@"blog with category_id= ,content=%@",content);
        
//        Blog blog = [[Blog alloc] init];
    } 
}

@end
