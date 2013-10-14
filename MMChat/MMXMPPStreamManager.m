//
//  MMXMPStreamManager.m
//  MMChat
//
//  Created by Josh Berlin on 10/8/13.
//  Copyright (c) 2013 Mutual Mobile. All rights reserved.
//

#import "MMXMPPStreamManager.h"

#import "MMGMailCredentials.h"
#import "MMXMPPReconnectManager.h"
#import "MMXMPPSendMessageManager.h"
#import "XMPPJID.h"
#import "XMPPLogging.h"
#import "XMPPStream.h"

#define XMPP_LOGGING_ENABLED 1

static const int xmppLogLevel = XMPP_LOG_LEVEL_INFO;

@interface MMXMPPStreamManager ()
@property(nonatomic, strong, readwrite) XMPPStream *xmppStream;
@property(nonatomic, strong) MMXMPPReconnectManager *xmppReconnectManager;
@property(nonatomic, strong) MMXMPPSendMessageManager *xmppSendMessageManager;
@end

@implementation MMXMPPStreamManager

- (id)initWithJabberId:(NSString *)jabberId {
  self = [super init];
  if (self) {
    _xmppStream = [[XMPPStream alloc] init];
    _xmppStream.myJID = [XMPPJID jidWithString:jabberId];
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    _xmppReconnectManager = [[MMXMPPReconnectManager alloc] initWithXMPPStreamManager:self];
    _xmppSendMessageManager = [[MMXMPPSendMessageManager alloc] initWithXMPPStreamManager:self];
  }
  return self;
}

- (void)connect {
  NSError *error = nil;
  if (![self.xmppStream connect:&error]) {
    XMPPLogError(@"Oops, I probably forgot something: %@", error);
    return;
  }
  XMPPLogInfo(@"Connection started");
}

- (void)xmppStreamWillConnect:(XMPPStream *)sender {
  XMPPLogInfo(@"Will connect");  
}

- (void)xmppStreamDidConnect:(XMPPStream *)sender {
  XMPPLogInfo(@"Socket did connect");
  [self.xmppStream authenticateWithPassword:kGMailPassword error:NULL];
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error {
  XMPPLogError(@"Did disconnect with error: %@", error);
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender {
  XMPPLogInfo(@"Did authenticate");
  [self.xmppSendMessageManager sendPresence];
}

@end
