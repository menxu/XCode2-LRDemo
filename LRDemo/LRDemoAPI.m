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

+(NSURL *)get_url:(NSString *)path{
    NSString *urlStr = [[NSString alloc] initWithFormat:@"%@%@%@%@%@",MAIN_PROCOTOL,MAIN_HOST,MAIN_PORT,MAIN_SPACE,path];
    NSLog(@"path:%@",urlStr);
    NSURL *url = [NSURL URLWithString:urlStr];
    [urlStr release];
    return url;
}

+ (NSArray *)getBlogList{
    __block NSArray *mutableBlogs = [[NSArray alloc] init];
    [self get_by_asynchronous_http_blog_lists:^(NSArray *blogs) {
        if (blogs) {
            mutableBlogs = [NSArray arrayWithArray:blogs];
            NSLog(@"+ (NSMutableArray *)getBlogList =  %d",mutableBlogs.count);
        }
    }];
    NSLog(@"+ (NSMutableArray *)getBlogList wai =  %d",mutableBlogs.count);
    return [mutableBlogs retain];
}

//---------  block块 -----------------
//    [LRDemoAPI get_by_asynchronous_http_blog_lists:^(NSArray *blogs) {
//        if (blogs) {
//            arr = [NSArray arrayWithArray:blogs];
//            NSLog(@"+ (NSMutableArray *)getBlogList =  %d",arr.count);
//            for (int i = 0 ; i< arr.count ; i ++) {
//                Blog *blog = [arr objectAtIndex:i];
//                NSLog(@"id: %@",blog.Title);
//            }
//        }
//    }];
//+ (void)publicTimelineTweetsWithBlock:(void (^)(NSArray *tweets))block {}
+ (void)get_by_asynchronous_http_blog_lists:(void (^)(NSArray *blogs))block{
    __block ASIHTTPRequest *request = [ ASIHTTPRequest requestWithURL: [self get_url:BLOG_LISTS]];
    
    // ASIHTTPRequest 支持 iOS 4.0 的块语法，你可以把委托方法定义到块中
    [request setCompletionBlock :^{
        // 请求响应结束，返回 responseString
        NSString *responseString = [request responseString ]; // 对于 2 进制数据，使用 NSData 返回 NSData *responseData = [request responseData];
//        NSLog ( @"%@" ,responseString);
        NSMutableArray *mutableBlogs = [self get_by_json_blogLists:responseString];
        if (block) {
            block([NSArray arrayWithArray:mutableBlogs]);
        }
    }];
    
    [request setFailedBlock :^{
        // 请求响应失败，返回错误信息
        NSError *error = [request error ];
        NSLog ( @"error:%@" ,[error userInfo ]);
        if (block) {
            block(nil);
        }
    }];
    [request startAsynchronous ];
}


+ (NSArray *)get_by_synchronous_api_blog_lists
{
    
    ASIHTTPRequest *request = [ ASIHTTPRequest requestWithURL: [self get_url:BLOG_LISTS]];
    [request startSynchronous];
    
    NSError *error = [request error];
    if (!error) {
        NSString *responseString = [request responseString];
        return [self get_by_json_blogLists:responseString];
    }
    return nil;
}

+ (NSMutableArray *)get_by_json_blogLists:(NSString *)json_str{
    NSData *data=[json_str dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *blogs=(NSArray *)[data mutableObjectFromJSONData];
    
    NSMutableArray *blog_lists = [[NSMutableArray alloc] init];

    for(int i=0;i<blogs.count;i++){
        NSDictionary *dicBlog=[blogs objectAtIndex:i];
        Blog *blog = [[Blog alloc] initWithJsonDictionary:dicBlog];
        [blog_lists addObject:blog];
        [blog release];
    }
    return [blog_lists autorelease];
}

//----------------------------------------------------------------------------------
+ (Parser *)getBlogList:(NSString *)userId
                  tagArray:(NSArray *)tagArray
             startPosition:(NSUInteger)startPosition
                    length:(NSUInteger)length
                  delegate:(id<ParserDelegate>)delegate
             useCacheFirst:(BOOL)useCacheFirst
            connectionType:(ConnectionType)type
{
    if (length == 0 || delegate == nil) {
        return nil;
    }
    NSMutableDictionary *jsonDictionary = [[[NSMutableDictionary alloc] init] autorelease];
    if (userId) {
        [jsonDictionary setObject:[NSArray arrayWithObject:userId] forKey:@"create_user"];
    }
    if (tagArray) {
        [jsonDictionary setObject:tagArray forKey:@"aags"];
    }
    [jsonDictionary setObject:[NSString stringWithFormat:@"%d",startPosition] forKey:@"offset"];
    [jsonDictionary setObject:[NSString stringWithFormat:@"%d",length] forKey:@"length"];
    NSData *json_data = [jsonDictionary JSONData];
    NSString *jsonString = [[NSString alloc] initWithData:json_data encoding:NSUTF8StringEncoding];
    NSString *requestedUrl = [[NSString alloc] initWithFormat:@"%@%@%@%@%@",MAIN_PROCOTOL,MAIN_HOST,MAIN_PORT,MAIN_SPACE,BLOG_LISTS];
    NSLog(@"requestedurl : %@" , requestedUrl);
    NSDictionary *postDictionary = [NSDictionary dictionaryWithObject:jsonString forKey:@"json"];
    
    Parser *parser = [[Parser alloc] initWithString:requestedUrl
                                           delegate:delegate
                                     postDictionary:postDictionary
                                     connectionType:type];
    parser.useCacheFirst = useCacheFirst;
    [parser parse];
    [jsonString release];
    [requestedUrl release];
//    [jsonDictionary release];
    return parser;
}

+ (Parser *)getBlogList:(NSString *)userId
               tagArray:(NSArray *)tagArray
          startPosition:(NSUInteger)startPosition
                 length:(NSUInteger)length
               delegate:(id<ParserDelegate>)delegate
          useCacheFirst:(BOOL)useCacheFirst{
    
    return [self getBlogList:userId
                       tagArray:tagArray
                  startPosition:startPosition
                         length:length
                       delegate:delegate
                  useCacheFirst:useCacheFirst
                 connectionType:ConnectionTypeAsynchronously];
}
























@end
