//
//  Parser.h
//  LRDemo
//
//  Created by menxu on 13-4-16.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Blog.h"
#import "LRDHttpRequest.h"

@class Parser;

@protocol ParserDelegate <NSObject>
@optional
-(void)parser:(Parser *)parser didFailWithFinish:(NSMutableArray *)blogList;
-(void)parser:(Parser *)parser didFailWithError: (NSString *)error;
@end

@interface Parser : NSObject<LRDHttpRequestDelegate>{
    id<ParserDelegate> _delegate;
    BOOL _canceled;
    BOOL _useCacheFirst;
    
    ConnectionType _connectionType;
    LRDHttpRequest *_downloader;
    
    NSString *url;
    NSDictionary *postDictionary;
    BOOL aborted; // Whether parse stopped due to abort
    BOOL parsing; // Whether the Parser has started parsing
    BOOL stopped; // Whether the parse was stopped
    BOOL failed;  // Whether the parse failed
    BOOL parsingComplete; // Whether parsing has completed
}

// Whether parsing was stopped
@property (nonatomic, readonly, getter=isStopped) BOOL stopped;

// Whether parsing failed
@property (nonatomic, readonly, getter=didFail) BOOL failed;

// Whether parsing is in progress
@property (nonatomic, readonly, getter=isParsing) BOOL parsing;

@property (nonatomic, assign) BOOL useCacheFirst;
@property (nonatomic, retain) NSDictionary *postDictionary;
@property (nonatomic, retain) NSString *url;

// Init Parser with a Url string, and have no post dictionary
- (id)initWithString:(NSString *)Url
            delegate:(id<ParserDelegate>)delegate
      postDictionary:(NSDictionary*)dictionary
      connectionType:(ConnectionType)type;

// Init Parser with a Url string
- (id)initWithString:(NSString *)Url
            delegate:(id<ParserDelegate>)delegate
      connectionType:(ConnectionType)type;

// Begin parsing
- (BOOL)parse;

- (void)cancel;

@end
