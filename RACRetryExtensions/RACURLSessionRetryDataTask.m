//
//  WNDURLSessionRetryDataTask.m
//
//  Created by Dal Rupnik on 08/01/15.
//  Copyright (c) 2015 arvystate.net. All rights reserved.
//

#import "RACURLSessionRetryDataTask.h"

@interface RACURLSessionRetryDataTask ()

@property (nonatomic, readwrite, assign) NSTimeInterval retryInterval;

/*!
 *  Stores how many retries will be done
 */
@property (nonatomic, readwrite, assign) NSInteger numberOfRetries;

/*!
 *  Stores how many retries are left to do (if failed)
 */
@property (nonatomic, assign) NSInteger retriesLeft;

//
// Private properties
//
@property (nonatomic, copy) NSURLRequest *request;

@property (nonatomic, copy) void (^completionHandler)(NSURLResponse *, id, NSError *);

@property (nonatomic, strong) NSURLSessionDataTask* currentTask;

@end

@implementation RACURLSessionRetryDataTask

- (instancetype)initWithRequest:(NSURLRequest *)request numberOfRetries:(NSInteger)numberOfRetries retryInterval:(NSTimeInterval)retryInterval completionHandler:(void (^)(NSURLResponse *, id, NSError *))completionHandler
{
    self = [super init];
    
    if (self)
    {
        self.request = request;
        
        self.retryInterval = retryInterval;
        self.numberOfRetries = numberOfRetries;
        
        self.retriesLeft = numberOfRetries - 1;
        
        self.completionHandler = completionHandler;
    }
    
    return self;
}

- (void)dealloc
{
    self.taskCreator = nil;
}

- (void)resume
{
    if (self.taskCreator)
    {
        self.currentTask = self.taskCreator(self.request, [self retryBlock]);
    }
    
    //NSLog(@"Calling URL...");
    
    [self.currentTask resume];
}

- (void)suspend
{
    [self.currentTask suspend];
}

- (void)cancel
{
    [self.currentTask cancel];
}

- (RACURLSessionRetryDataTaskBlock)retryBlock
{
    RACURLSessionRetryDataTaskBlock retryBlock = ^(NSURLResponse *response, id responseObject, NSError *error)
    {
        //NSLog(@"Retry block called");
        
        if (error)
        {
            BOOL retryTest = YES;
            
            if (self.testBlock)
            {
                retryTest = self.testBlock(response, responseObject, error);
            }
            
            //
            // This is the retry logic
            //
            if ( (self.retriesLeft > 0) && retryTest)
            {
                //NSLog(@"Retrying for: %ld", (long)self.retriesLeft);
                
                self.retriesLeft--;
                
                [self.currentTask cancel];
                self.currentTask = nil;
                
                dispatch_time_t delay = dispatch_time(0, (int64_t)(self.retryInterval * NSEC_PER_SEC));
                dispatch_after(delay, dispatch_get_main_queue(), ^(void)
                {
                    [self resume];
                });
            }
            else if (self.completionHandler)
            {
                self.completionHandler(response, responseObject, error);
            }
        }
        else if (self.completionHandler)
        {
            self.completionHandler(response, responseObject, error);
        }
    };
    
    return retryBlock;
}

@end
