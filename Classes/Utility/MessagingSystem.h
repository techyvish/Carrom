//
//  MessagingSystem.h
//  MessagingTest
//
//  Created by Juan Albero Sanchis on 15/03/10.
//  Copyright 2010 Aggressive Mediocrity. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AMSubscribe(aSelector, aMessage, aObject) \
[[NSNotificationCenter defaultCenter] addObserver:(self) selector:(aSelector) name:(aMessage) object:(aObject)]

#define AMUnsubscribeMessage (aMessage) \
[[NSNotificationCenter defaultCenter] removeObserver:(self) forKeyPath:(aMessage)]

#define AMUnsubscribe \
[[NSNotificationCenter defaultCenter] removeObserver:(self)]

#define AMSendMessage(aMessage, aObject) \
[[NSNotificationCenter defaultCenter] postNotificationName:(aMessage) object:(aObject)]

