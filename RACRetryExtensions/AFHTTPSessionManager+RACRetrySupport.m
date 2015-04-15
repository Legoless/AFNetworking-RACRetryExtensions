//
//  AFHTTPSessionManager+RACRetrySupport.m
//
//  Created by Dal Rupnik on 10/14/14
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import "AFHTTPSessionManager+RACRetrySupport.h"
#import "RACURLSessionRetryDataTask.h"

NSTimeInterval const RACDefaultTimeInterval = 10.0;

@implementation AFHTTPSessionManager (RACRetrySupport)

#pragma mark - GET

- (RACSignal *)rac_GET:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries
{
    return [self rac_GET:path parameters:parameters retries:retries interval:RACDefaultTimeInterval test:nil];
}

- (RACSignal *)rac_GET:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval
{
    return [self rac_GET:path parameters:parameters retries:retries interval:interval test:nil];
}

- (RACSignal *)rac_GET:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval test:(RACURLSessionRetryTestBlock)testBlock
{
    return [[self rac_requestPath:path parameters:parameters method:@"GET" retries:retries interval:interval test:testBlock]
            setNameWithFormat:@"%@ -rac_GET: %@, parameters: %@", self.class, path, parameters];
}

#pragma mark - HEAD

- (RACSignal *)rac_HEAD:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries
{
    return [self rac_HEAD:path parameters:parameters retries:retries interval:RACDefaultTimeInterval test:nil];
}

- (RACSignal *)rac_HEAD:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval
{
    return [self rac_HEAD:path parameters:parameters retries:retries interval:interval test:nil];
}

- (RACSignal *)rac_HEAD:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval test:(RACURLSessionRetryTestBlock)testBlock
{
    return [[self rac_requestPath:path parameters:parameters method:@"HEAD" retries:retries interval:interval test:testBlock]
            setNameWithFormat:@"%@ -rac_HEAD: %@, parameters: %@", self.class, path, parameters];
}

#pragma mark - POST

- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries
{
    return [self rac_POST:path parameters:parameters retries:retries interval:RACDefaultTimeInterval test:nil];
}

- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval
{
    return [self rac_POST:path parameters:parameters retries:retries interval:interval test:nil];
}

- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval test:(RACURLSessionRetryTestBlock)testBlock
{
    return [[self rac_requestPath:path parameters:parameters method:@"POST" retries:retries interval:interval test:testBlock]
            setNameWithFormat:@"%@ -rac_POST: %@, parameters: %@", self.class, path, parameters];
}

- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block retries:(NSInteger)retries
{
    return [self rac_POST:path parameters:parameters constructingBodyWithBlock:block retries:retries interval:RACDefaultTimeInterval test:nil];
}

- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block retries:(NSInteger)retries interval:(NSTimeInterval)interval
{
    return [self rac_POST:path parameters:parameters constructingBodyWithBlock:block retries:retries interval:interval test:nil];
}

- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block retries:(NSInteger)retries interval:(NSTimeInterval)interval test:(RACURLSessionRetryTestBlock)testBlock
{
    return [[RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:nil];
        
        RACURLSessionRetryDataTask *task = [self URLSessionRetryDataTaskForRequest:request numberOfRetries:retries retryInterval:interval test:testBlock subscriber:subscriber];
        
        [task resume];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }] setNameWithFormat:@"%@ -rac_POST: %@, parameters: %@, constructingBodyWithBlock:", self.class, path, parameters];
}

#pragma mark - PUT

- (RACSignal *)rac_PUT:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries
{
    return [self rac_PUT:path parameters:parameters retries:retries interval:RACDefaultTimeInterval test:nil];
}

- (RACSignal *)rac_PUT:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval
{
    return [self rac_PUT:path parameters:parameters retries:retries interval:interval test:nil];
}

- (RACSignal *)rac_PUT:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval test:(RACURLSessionRetryTestBlock)testBlock
{
    return [[self rac_requestPath:path parameters:parameters method:@"PUT" retries:retries interval:interval test:testBlock]
            setNameWithFormat:@"%@ -rac_PUT: %@, parameters: %@", self.class, path, parameters];
}

#pragma mark - PATCH

- (RACSignal *)rac_PATCH:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries
{
    return [self rac_PATCH:path parameters:parameters retries:retries interval:RACDefaultTimeInterval test:nil];
}
- (RACSignal *)rac_PATCH:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval
{
    return [self rac_PATCH:path parameters:parameters retries:retries interval:interval test:nil];
}

- (RACSignal *)rac_PATCH:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval test:(RACURLSessionRetryTestBlock)testBlock
{
    return [[self rac_requestPath:path parameters:parameters method:@"PATCH" retries:retries interval:interval test:testBlock]
            setNameWithFormat:@"%@ -rac_PATCH: %@, parameters: %@", self.class, path, parameters];
}

#pragma mark - DELETE

- (RACSignal *)rac_DELETE:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries
{
    return [self rac_DELETE:path parameters:parameters retries:retries interval:RACDefaultTimeInterval test:nil];
}
- (RACSignal *)rac_DELETE:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval
{
    return [self rac_DELETE:path parameters:parameters retries:retries interval:interval test:nil];
}

- (RACSignal *)rac_DELETE:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval test:(RACURLSessionRetryTestBlock)testBlock
{
    return [[self rac_requestPath:path parameters:parameters method:@"DELETE" retries:retries interval:interval test:testBlock]
            setNameWithFormat:@"%@ -rac_DELETE: %@, parameters: %@", self.class, path, parameters];
}

#pragma mark - GLOBAL

- (RACSignal *)rac_requestPath:(NSString *)path parameters:(id)parameters method:(NSString *)method retries:(NSInteger)retries interval:(NSTimeInterval)interval test:(RACURLSessionRetryTestBlock)testBlock
{
    return [RACSignal createSignal:^(id<RACSubscriber> subscriber)
    {
        NSURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
        
        //
        // Retry data task will create tasks multiple times and keep executing them unless canceled
        //
        RACURLSessionRetryDataTask *task = [self URLSessionRetryDataTaskForRequest:request numberOfRetries:retries retryInterval:interval test:testBlock subscriber:subscriber];
        
        [task resume];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

/*!
 *  Allocates new retriable URL session
 *
 *  @param request         to retry
 *  @param numberOfRetries number of retries to be done before failing
 *  @param retryInterval   cooldown time before next retry
 *  @param testBlock       block to test for sensibility of retry
 *  @param subscriber      reactive subscriber
 *
 *  @return retriable data task - calls failed when all retries are finished
 */
- (RACURLSessionRetryDataTask *)URLSessionRetryDataTaskForRequest:(NSURLRequest *)request numberOfRetries:(NSInteger)numberOfRetries retryInterval:(NSTimeInterval)retryInterval test:(RACURLSessionRetryTestBlock)testBlock subscriber:(id<RACSubscriber>)subscriber
{
    RACURLSessionRetryDataTask* task = [[RACURLSessionRetryDataTask alloc] initWithRequest:request numberOfRetries:numberOfRetries retryInterval:retryInterval completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
    {
        if (error)
        {
            [subscriber sendError:error];
        }
        else
        {
            [subscriber sendNext:RACTuplePack(responseObject, response)];
            [subscriber sendCompleted];
        }
    }];
    
    //
    // Because online manager's job is to handle the creation of data tasks, we need to give a block to the task that will create a new data task
    // and execute retry block provided by retry data task object. This is because the retry logic is wrapped in retry data task object,
    // we must execute it's retry block instead of completing based on our own criteria.
    //
    
    task.taskCreator = ^NSURLSessionDataTask*(NSURLRequest *request, RACURLSessionRetryDataTaskBlock retryBlock)
    {
        return [self dataTaskWithRequest:request completionHandler:retryBlock];
    };
    
    if (testBlock)
    {
        task.testBlock = testBlock;
    }
    
    return task;
}

@end
