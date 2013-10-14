//
//  MMXMPPReconnectManager.h
//  MMChat
//
//  Created by Josh Berlin on 10/8/13.
//  Copyright (c) 2013 Mutual Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMXMPPStreamManager.h"

@interface MMXMPPReconnectManager : NSObject

- (id)initWithXMPPStreamManager:(MMXMPPStreamManager *)xmppStreamManager;

@end
