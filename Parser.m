//
//  Parser.m
//  LRDemo
//
//  Created by menxu on 13-4-16.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import "Parser.h"
#import "GlobalDef.h"
#import "JSONKit.h"

@implementation Parser

@synthesize url;
@synthesize postDictionary;
@synthesize stopped, failed, parsing;
@synthesize useCacheFirst = _useCacheFirst;

- (id)initWithString:(NSString *)Url
            delegate:(id<ParserDelegate>)delegate
      connectionType:(ConnectionType)type{
    return [self initWithString:Url delegate:delegate postDictionary:nil connectionType:type];
}
- (id)initWithString:(NSString *)Url
            delegate:(id<ParserDelegate>)delegate
      postDictionary:(NSDictionary*)dictionary
      connectionType:(ConnectionType)type
{
    if (delegate == nil)
        return nil;
    
    if (type != ConnectionTypeSynchronously && type != ConnectionTypeAsynchronously)
        return nil;
    
    if (self = [self init]) {
        
        // Remember url
        self.url = Url;
        _delegate = delegate;
        _connectionType = type;
        
        if (dictionary)
            self.postDictionary = dictionary;
    }
    
    return self;
}
- (void)cancel{
    _canceled = TRUE;
    _delegate = nil;
    [_downloader cancel];
    RELEASE_SAFELY(_downloader);
}

- (BOOL)parse{
    if (_canceled)
        return TRUE;
    
    // Perform checks before parsing
    if (!url || !_delegate) {
        [self parsingFailedWithDescription:@"Delegate or URL not specified"];
        return NO;
    }
    if (parsing) {
        [self parsingFailedWithDescription:@"Cannot start parsing as parsing is already in progress"];
        return NO;
    }
    
    // Reset state for next parse
    parsing = YES;
    aborted = NO;
    stopped = NO;
    failed = NO;
    parsingComplete = NO;
    
    if (_downloader) {
        [_downloader cancel];
        RELEASE_SAFELY(_downloader);
    }
    
    _downloader = [[LRDHttpRequest alloc] initWithString:url
                                                delegate:self
                                          postDictionary:postDictionary
                                          connectionType:_connectionType];
    _downloader.useCacheFirst = self.useCacheFirst;
    [_downloader download];
    NSLog(@"- (BOOL)parse");
    return true;
}

// If an error occurs, create NSError and inform delegate
- (void)parsingFailedWithDescription:(NSString *)description {
    // Finish & create error
    if (!parsingComplete) {
        // State
        failed = YES;
        parsing = NO;
        parsingComplete = YES;
    }
    // Inform delegate
    if (!_useCacheFirst && !_canceled && [_delegate respondsToSelector:@selector(parser:didFailWithError:)])
        [_delegate parser:self didFailWithError:description];
}
- (NSMutableArray *)get_by_json_blogLists:(NSString *)json_str{
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

- (void)parserDidFinish:(NSString *)responseString{
    [_delegate parser:self didFailWithFinish:[self get_by_json_blogLists:responseString]];
}
#pragma mark -
#pragma mark LRDHttpRequestDelegate
- (void)responseString:(NSString *)responseString{
    NSLog(@"- (void)responseString:(NSString *)responseString : " );
//    NSLog(@"- (void)responseString:(NSString *)responseString :  %@" , responseString);
    [self parserDidFinish:responseString];
}
- (void)responseError:(NSError *)error{
    NSLog(@"------ - (void)responseError:(NSError *)error");
}
@end
