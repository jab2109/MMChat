//
//  MMXMPPSendMessageManager.m
//  MMChat
//
//  Created by Josh Berlin on 10/8/13.
//  Copyright (c) 2013 Mutual Mobile. All rights reserved.
//

#import "MMXMPPSendMessageManager.h"

#import "MMGMailCredentials.h"
#import "MMXMPPStreamManager.h"
#import "XMPPLogging.h"
#import "XMPPJID.h"
#import "XMPPMessage.h"
#import "XMPPStream.h"

#import "XMPPPresence.h"

static const int xmppLogLevel = XMPP_LOG_LEVEL_INFO;

@interface MMXMPPSendMessageManager ()
@property(nonatomic, strong) MMXMPPStreamManager *xmppStreamManager;
@property(nonatomic, strong) XMPPJID *toJID;
@end

@implementation MMXMPPSendMessageManager

- (id)initWithXMPPStreamManager:(MMXMPPStreamManager *)xmppStreamManager {
  self = [super init];
  if (self) {
    _xmppStreamManager = xmppStreamManager;
    [_xmppStreamManager.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    _toJID = [XMPPJID jidWithString:kGMailUsername];
  }
  return self;
}

- (void)sendPresence {
  XMPPPresence *presence = [XMPPPresence presenceWithType:nil to:self.toJID];
  [self.xmppStreamManager.xmppStream sendElement:presence];
}

- (void)sendMessage {
  DDXMLElement *body = [DDXMLElement elementWithName:@"body"];
  [body setStringValue:@"What up dawg! ~ from MMChat ~"];
  
  XMPPMessage *xmppMessage = [XMPPMessage messageWithType:@"chat" to:self.toJID];
  [xmppMessage addChild:body];
  
  [self.xmppStreamManager.xmppStream sendElement:xmppMessage];
}

- (void)xmppStream:(XMPPStream *)sender didSendPresence:(XMPPPresence *)presence {
  XMPPLogInfo(@"Did send presence: %@", presence);
  [self sendMessage];
}

- (void)xmppStream:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message {
  XMPPLogInfo(@"Did send message: %@", message);
  if ([message isErrorMessage]) {
    XMPPLogError(@"Error message");
  }
}

@end
