//
//  LRDHttpRequest.m
//  LRDemo
//
//  Created by menxu on 13-4-17.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import "LRDHttpRequest.h"
#import "ASIDownloadCache.h"
#import "GlobalDef.h"
@interface LRDHttpRequest ()
// Properties that don't need to be seen by the outside world.

@property (nonatomic, copy)     NSString *url;
@property (nonatomic, retain)   NSMutableData   * asyncData;
@property (nonatomic, copy)     NSString *        filePath;
@property (nonatomic, retain)   NSOutputStream *  fileStream;

@end

@implementation LRDHttpRequest

@synthesize url            = _url;
@synthesize postDictionary = _postDictionary;
@synthesize asyncData      = _asyncData;
@synthesize filePath       = _filePath;
@synthesize fileStream     = _fileStream;
@synthesize asiRequest;
@synthesize useCacheFirst  = _useCacheFirst;

- (id)init {
    if (self = [super init]) {
        _canceled = FALSE;
        _useCacheFirst = YES;
    }
    return self;
}

- (id)initWithString:(NSString *)Url
            delegate:(id<LRDHttpRequestDelegate>)delegate
      connectionType:(ConnectionType)cType
{
    return [self initWithString:Url
                       delegate:delegate
                 postDictionary:nil
                 connectionType:cType];
}

// Initialise with a URL
- (id)initWithString:(NSString *)Url
            delegate:(id<LRDHttpRequestDelegate>)delegate
      postDictionary:(NSDictionary*)dictionary
      connectionType:(ConnectionType)cType
{
    if (delegate == nil)
        return nil;
    
    self.postDictionary = dictionary;
    
    if (cType != ConnectionTypeSynchronously && cType != ConnectionTypeAsynchronously)
        return nil;
    
    if (self = [self init]) {
        
        // Remember url
        self.url = Url;
        _delegate = delegate;
        _connectionType = cType;
    }
    
    return self;
}

- (void)dealloc
{
    RELEASE_SAFELY(_url);
    RELEASE_SAFELY(_asyncData);
    RELEASE_SAFELY(_postDictionary);
    
    if (asiRequest) {
        [asiRequest clearDelegatesAndCancel];
        RELEASE_SAFELY(asiRequest);
    }
    
    [super dealloc];
}
- (void)cancel
{
    _canceled = TRUE;
    if (asiRequest) {
        [asiRequest clearDelegatesAndCancel];
        RELEASE_SAFELY(asiRequest);
    }
    
    _delegate = nil;
}

// Begin to download
- (void)download
{
    if (!_canceled)
        [self _startReceive];
}

- (void)_startReceive
// Starts a connection to download the current URL.
{
    BOOL success;
    
    // First get and check the URL.
    success = (self.url != nil);
    
    if (!success)
    {
        NSLog(@"Downloader: Invalid URL");
        return;
    }

    NSMutableString *requestedUrl = [[NSMutableString alloc] initWithString:self.url];
    //如果Post字典不为空，添加到asiRequest中
    if (_postDictionary) {
        NSArray *keys = [_postDictionary allKeys];
        
        for (int i = 0; i < [keys count]; i++) {
            NSString *key = [keys objectAtIndex:i];
            NSString *value = [_postDictionary objectForKey:key];
            
            if ([key length] == 0 || [value length] == 0) {
                continue;
            }
            
            [requestedUrl appendString:i==0 ? @"?" : @"&"];
            [requestedUrl appendFormat:@"%@=%@", key, value];
        }
    }
    
    self.asiRequest = [ASIHTTPRequest requestWithURL:
                       [NSURL URLWithString:[requestedUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];

    // Connection
    if (_connectionType == ConnectionTypeAsynchronously) {
        
        [asiRequest setDelegate:self];
        [asiRequest startAsynchronous];
    }else{
        [asiRequest startSynchronous];
        
        NSError *error = [asiRequest error];
        if (!error){
            [self requestFinished:asiRequest];
        }else{
            [self requestFailed:asiRequest];
        }
    }
    [requestedUrl release];
}
- (void)requestFinished:(ASIHTTPRequest *)request {
//     NSString *responseString = [request responseString ]; // 对于 2 进制数据，使用 NSData 返回 NSData *responseData = [request responseData];
    [_delegate responseString:[request responseString]];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
//    NSError *error = [request error];
    [_delegate responseError:[request error]];
}


@end
