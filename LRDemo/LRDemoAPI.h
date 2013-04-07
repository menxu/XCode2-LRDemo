//
//  LRDemoAPI.h
//  LRDemo
//
//  Created by menxu on 13-4-3.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#define IKNOW_OFFICIAL_ID   @"official_id"

#define MAIN_PROCOTOL       @"http://"

#define MAIN_HOST           @"192.168.1.108"
#define MAIN_PORT           @":80"

#define MAIN_PATH_C         @"/path/"
#define MAIN_PATH_U         MAIN_PATH_C
#define MAIN_PATH_A         MAIN_PATH_C

#define MAIN_PATH           MAIN_PATH_C


#define CONTENT_LIST_PATH    @"content_list.do"
#define CONTENT_PATH         @"content.do"
#define ADD_CONTENT_PATH     @"add_content.do"
#define SET_CONTENT_TAG_PATH @"set_content_tag.do"

#define TAG_LIST_PATH        @"tag_list.do"

#define COMMENT_LIST_PATH    @"comment_list.do"
#define ADD_COMMENT_PATH     @"add_comment.do"

#define FAVORITE_LIST_PATH   @"favorite_list.do"
#define EDIT_FAVORITE_PATH   @"edit_favorite.do"

#define WORD_LIST_PATH       @"word_list.do"
#define EDIT_WORD_PATH       @"edit_word.do"

#define JSESSION_PATH        @"index.do"

#define FEEDBACK_PATH         @"feedback.do"

#define THUMB_IMAGE_PATH    @"resize_img.do"


//admin

#define DELETE_ARTICLE      @"content_edit.do"

//Others

#define SHORT_URL_PATH   @"http://api.t.sina.com.cn/short_url/shorten.json"
#define SHORT_URL_KEY    kShareToCNKey

#define BINGURL  @"http://api.microsofttranslator.com/v2/Http.svc/Translate?text="
#define BING_TOKEN @"https://datamarket.accesscontrol.windows.net/v2/OAuth2-13"
#define SCOPE   @"http://api.microsofttranslator.com"
#define GRANTTYPE  @"client_credentials"

#import <Foundation/Foundation.h>

@interface LRDemoAPI : NSObject

@end
