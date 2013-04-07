//
//  Client.h
//  LRDemo
//
//  Created by menxu on 13-4-3.
//  Copyright (c) 2013年 menxu. All rights reserved.
//
#define IKNOW_WILL_REGISTER_TEXT                NSLocalizedString(@"注册中...", @"")

#define IKNOW_REGISTER_FAILED_TEXT              NSLocalizedString(@"注册失败", @"")
#define IKNOW_REGISTER_FAILED_BY_EMAIL          NSLocalizedString(@"该邮箱已注册", @"")

#define IKNOW_WILL_LOGIN_TEXT                   NSLocalizedString(@"登录中...", @"")
#define IKNOW_LOGIN_FAILED_BY_EMAIL_OR_PASSEORD NSLocalizedString(@"登录失败", @"")

#define IKNOW_XMPP_WAIT                         NSLocalizedString(@"请稍候...", @"")

//xmpp
#define IKNOW_XMPP_REGISTER_FAILED_TEXT         NSLocalizedString(@"注册失败", @"")
#define IKNOW_XMPP_REGISTER_SUCCESSED_TEXT      @""

#define IKNOW_XMPP_MESSAGE_SEND_FAILED_TEXT     NSLocalizedString(@"消息发送失败", @"")
#define IKNOW_XMPP_MESSAGE_SEND_SUCCESSED_TEXT  @""
#define IKNOW_XMPP_MESSAGE_WILL_SEND_TEXT       NSLocalizedString(@"消息发送中", @"")

#define DEFAULT_NAME NSLocalizedString(@"匿名", @"")
#define DEFAULT_MSG_NAME DEFAULT_NAME


#define DOCUMENT_FOLDER	   [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define AUDIO_CACHE_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/ASIHTTPRequestCache/PermanentStore"]
#define IMAGE_CACHE_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/ASIHTTPRequestCache/PermanentStore"]

#define TRANSLATOR_CACHE  [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/ASIHTTPRequestCache/PermanentStore/Translator"]

#define UPLOAD_MSG_RESOURCE_PATH    @"upload.do"
#define DOWNLOAD_MSG_RESOURCE_PATH      @"/iks/"

#define DOWNLOAD_RESOURCE_PATH          @"/iks"

#define FILE_PATH             MAIN_PATH_U


#define DEFAULT_LONGITUDE 116.414507
#define DEFAULT_LATITUDE 40.041869
#define DEFAULT_DELTA 5.0



#import <Foundation/Foundation.h>

@interface Client : NSObject

@end
