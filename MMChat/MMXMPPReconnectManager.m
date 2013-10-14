//
//  MMXMPPReconnectManager.m
//  MMChat
//
//  Created by Josh Berlin on 10/8/13.
//  Copyright (c) 2013 Mutual Mobile. All rights reserved.
//

#import "MMXMPPReconnectManager.h"

#import "XMPPReconnect.h"

@interface MMXMPPReconnectManager ()
@property(nonatomic, strong) MMXMPPStreamManager *xmppStreamManager;
@property(nonatomic, strong) XMPPReconnect *xmppReconnect;
@end

@implementation MMXMPPReconnectManager

- (id)initWithXMPPStreamManager:(MMXMPPStreamManager *)xmppStreamManager {
  self = [super init];
  if (self) {
    _xmppStreamManager = xmppStreamManager;
    
    _xmppReconnect = [[XMPPReconnect alloc] init];
    [_xmppReconnect activate:_xmppStreamManager.xmppStream];
    [_xmppReconnect addDelegate:self delegateQueue:dispatch_get_main_queue()];
  }
  return self;
}

@end
