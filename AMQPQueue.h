//
//  AMQPQueue.h
//  This file is part of librabbitmq-objc.
//  Copyright (C) 2014 *Prof. MAAD* aka Max Wolter
//  librabbitmq-objc is released under the terms of the GNU Lesser General Public License Version 3.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Lesser General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//  
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Lesser General Public License for more details.
//  
//  You should have received a copy of the GNU Lesser General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

#import "amqp.h"

#import "AMQPObject.h"

@class AMQPChannel;
@class AMQPExchange;
@class AMQPConsumer;

@interface AMQPQueue : AMQPObject
{
	amqp_bytes_t queueName;
	
	AMQPChannel *channel;
}

@property (readonly) amqp_bytes_t internalQueue;

- (id)initWithName:(NSString*)theName onChannel:(AMQPChannel*)theChannel isPassive:(BOOL)passive isExclusive:(BOOL)exclusive isDurable:(BOOL)durable getsAutoDeleted:(BOOL)autoDelete;
- (void)dealloc;

- (void)bindToExchange:(AMQPExchange*)theExchange withKey:(NSString*)bindingKey;
- (void)unbindFromExchange:(AMQPExchange*)theExchange withKey:(NSString*)bindingKey;

- (AMQPConsumer*)startConsumerWithAcknowledgements:(BOOL)ack isExclusive:(BOOL)exclusive receiveLocalMessages:(BOOL)local;

@end
