//
//  XGNetworkCommand.h
//  XMLGeoLocationDemo
//
//  Created by Jiuzheng Chen on 7/6/14.
//  Copyright (c) 2014 Jiuzheng Chen. All rights reserved.
//

typedef void(^NetworkCommandCompletionBlock)(BOOL success, NSDictionary *response);

@interface XGNetworkCommand : NSObject

@property (nonatomic, copy) NetworkCommandCompletionBlock completeBlock;
@property (nonatomic) BOOL isRunning;

+ (void)enqueueCommandWithCallback:(NetworkCommandCompletionBlock)completeCallback;

- (instancetype)initWithCompleteBlock:(NetworkCommandCompletionBlock) completeBlock;
- (instancetype)enqueue;

@end
