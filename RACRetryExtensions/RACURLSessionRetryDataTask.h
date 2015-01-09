//
//  RACURLSessionDataTask.h
//
//  Created by Dal Rupnik on 08/01/15.
//  Copyright (c) 2015 arvystate.net. All rights reserved.
//

#pragma mark - Usage blocks

typedef void (^RACURLSessionRetryDataTaskBlock)(NSURLResponse *response, id responseObject, NSError *error);
typedef BOOL (^RACURLSessionRetryTestBlock)(NSURLResponse *response, id responseObject, NSError *error);

/*!
 *  Block that allocates a new task, is used by AFHTTPSessionManager
 *
 *  @param request    provides request
 *  @param retryBlock retry block to be executed when data task fails
 *
 *  @return new NSURLSessionDataTask
 */
typedef NSURLSessionDataTask* (^RACURLSessionDataTaskCreator)(NSURLRequest *request, RACURLSessionRetryDataTaskBlock retryBlock);

#pragma mark - RACURLSessionRetryDataTask

/*!
 *  Wrapper that creates and executes multiple data tasks one after one
 */
@interface RACURLSessionRetryDataTask : NSObject

@property (nonatomic, readonly) NSTimeInterval retryInterval;

@property (nonatomic, readonly) NSInteger numberOfRetries;

/*!
 *  Must be set so each retry has gets allocated a new task
 */
@property (nonatomic, copy) RACURLSessionDataTaskCreator taskCreator;

/*!
 *  Optional, if set, it is called on error and must return YES,
 *  if retry criteria is matched, this enables you to stop retries under special conditions, such as
 *  4xx errors.
 */
@property (nonatomic, copy) RACURLSessionRetryTestBlock testBlock;

- (instancetype)initWithRequest:(NSURLRequest *)request numberOfRetries:(NSInteger)numberOfRetries retryInterval:(NSTimeInterval)retryInterval completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler;

- (void)resume;

- (void)suspend;

- (void)cancel;

@end
