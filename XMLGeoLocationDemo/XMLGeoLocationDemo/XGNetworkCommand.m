//
//  XGNetworkCommand.m
//  XMLGeoLocationDemo
//
//  Created by Jiuzheng Chen on 7/6/14.
//  Copyright (c) 2014 Jiuzheng Chen. All rights reserved.
//

#import "XGNetworkCommand.h"
#import "XMLReader.h"

@interface XGNetworkCommand ()

@end

@implementation XGNetworkCommand

static NSString *_serverEndPoint = @"http://interview.engineering.levolabs.com/locations.xml";

static NSMutableArray *_commands;

+ (void)initialize
{
    _commands = [NSMutableArray array];
}

+ (void)enqueueCommandWithCallback:(NetworkCommandCompletionBlock)completeCallback
{
    [[[self alloc] initWithCompleteBlock:completeCallback] enqueue];
}

- (void)commandCallback:(BOOL)success response:(NSDictionary *)response
{
    self.completeBlock(success, response);
}

- (instancetype)initWithCompleteBlock:(NetworkCommandCompletionBlock)completeBlock
{
    self = [super init];
    if (self)
    {
        self.completeBlock = completeBlock;
    }
    return self;
}

- (instancetype)enqueue
{
    @synchronized(self)
    {
        [_commands addObject:self];
    }
    [self processCommands];
    return self;
}

- (void)processCommands
{
    XGNetworkCommand *firstCommand = nil;
    @synchronized(self)
    {
        if (_commands.count > 0)
        {
            firstCommand = [_commands firstObject];
        }
    }
    
    if (!firstCommand.isRunning)
    {
        [firstCommand execute];
    }
}

- (void)execute
{
    self.isRunning = YES;
    
    NSURL *requestUrl = [NSURL URLWithString:_serverEndPoint];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        @synchronized(self)
        {
            [_commands removeObject:self];
        }
        
        NSError * httpStatusError;
        NSError * decodeError;
        NSDictionary * result;
        // check for any response errors
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if ((([httpResponse statusCode]/100) == 2) && [[response MIMEType] isEqual:@"text/xml"])
        {
            
            // Since we only have a small number of entries in the response XML,
            // doing XML parsing on main thread should be OK.
            // If XML is very large, then we should use NSOperationQueue to run that asynchronously
            result = [XMLReader dictionaryForXMLData:data error:&decodeError];
        }
        else
        {
            NSString *errorString = @"HTTP Error";
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorString};
            httpStatusError = [NSError errorWithDomain:@"HTTP"
                                                       code:[httpResponse statusCode]
                                                   userInfo:userInfo];
        }
        
        if (connectionError || decodeError || !result)
        {
            [self commandCallback:NO response:nil];
        }
        else
        {
            [self commandCallback:YES response:result];
        }
        [self processCommands];
    }];
}

@end
