//
//  LRDHttpRequest.h
//  LRDemo
//
//  Created by menxu on 13-4-17.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

// Types
typedef enum {
    ConnectionTypeAsynchronously,
    ConnectionTypeSynchronously
} ConnectionType;

@class LRDHttpRequest;

@protocol LRDHttpRequestDelegate <NSObject>

@optional
- (void)responseString:(NSString *)responseString;
- (void)responseError:(NSError *)error;

@end

@interface LRDHttpRequest : NSObject{
    NSString *_url;
    NSDictionary *_postDictionary;
    NSMutableData   * _asyncData;
    BOOL _canceled;
    BOOL _useCacheFirst;
    
    id <LRDHttpRequestDelegate> _delegate;
    
    ConnectionType _connectionType;
    
    ASIHTTPRequest *asiRequest;
}
@property (nonatomic, retain) ASIHTTPRequest *asiRequest;
@property (nonatomic, retain) NSDictionary *postDictionary;
@property (nonatomic, assign) BOOL useCacheFirst;

// Init Downloader with a Url string, and have no post dictionary
- (id)initWithString:(NSString *)Url
            delegate:(id<LRDHttpRequestDelegate>)delegate
      connectionType:(ConnectionType)cType;

// Init Downloader with a Url string
- (id)initWithString:(NSString *)Url
            delegate:(id<LRDHttpRequestDelegate>)delegate
      postDictionary:(NSDictionary*)dictionary
      connectionType:(ConnectionType)cType;

// Begin downloading
- (void)download;
- (void)cancel;

// Returns the URL
- (NSString *)url;
@end
