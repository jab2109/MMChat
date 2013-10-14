//
//  MMXMPStreamManager.h
//  MMChat
//
//  Created by Josh Berlin on 10/8/13.
//  Copyright (c) 2013 Mutual Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMPPStream;

@interface MMXMPPStreamManager : NSObject

@property(nonatomic, strong, readonly) XMPPStream *xmppStream;

- (id)initWithJabberId:(NSString *)jabberId;

- (void)connect;

@end
