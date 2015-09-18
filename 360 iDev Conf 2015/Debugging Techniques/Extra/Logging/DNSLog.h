//
//  KGDebugging.pch
//  KGFramework
//
//  Created by Kendall Gelner on 1/24/10.
//  Copyright 2010 KiGi Software. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef __OBJC__

#ifdef DEBUG
// Bog standard Logging
    #define DNSLog(fmt, ...) NSLog(fmt, ##__VA_ARGS__);
// Log statement with a bit more detail as to where you are
    #define DNSLog1(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
// Log statement without the normal NSLog fluff at the start 
    #define DNSLog2(fmt, ...) fprintf( stderr, "%s\n", [[NSString stringWithFormat:(@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__] UTF8String] );
// Logs out to a UILocalNotification, where you can pull it down in Notification Center
#define DNSLogN(fmt, ...) UILocalNotification *localNotif__LINE__ = [[UILocalNotification alloc] init];\
if (localNotif__LINE__) {\
    localNotif__LINE__.alertBody = [NSString stringWithFormat:(fmt), ##__VA_ARGS__];\
    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotif__LINE__];\
}

// You can use this type to delay expensive logging computation by wrapping it in a block.
typedef NSString *(^LoggingOnlyComposeString)();

#else
// No definition unless debugging is on
    #define DNSLog(fmt, ...)
    #define DNSLog1(fmt, ...)
    #define DNSLog2(fmt, ...)
    #define DNSLogN(fmt, ...)
#endif

#endif
