//
//  MMAppDelegate.m
//  MMChat
//
//  Created by Josh Berlin on 10/8/13.
//  Copyright (c) 2013 Mutual Mobile. All rights reserved.
//

#import "MMAppDelegate.h"

#import "MMGMailCredentials.h"
#import "MMXMPPStreamManager.h"
#import "DDLog.h"
#import "DDTTYLogger.h"

@interface MMAppDelegate ()
@property(nonatomic, strong) MMXMPPStreamManager *xmppStreamManager;
@end

@implementation MMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [DDLog addLogger:[DDTTYLogger sharedInstance]];
  self.xmppStreamManager = [[MMXMPPStreamManager alloc] initWithJabberId:kGMailUsername];
  [self.xmppStreamManager connect];
  return YES;
}

@end
