#pragma mark -
#pragma mark DownloaderDelegate//
//  main.m
//  LRDemo
//
//  Created by menxu on 13-3-22.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char *argv[])
{
#if __has_feature(objc_arc) && __clang_major__ >= 3
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
#else
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    [pool release];
    return retVal;
#endif // __has_feature(objc_arc)
}
