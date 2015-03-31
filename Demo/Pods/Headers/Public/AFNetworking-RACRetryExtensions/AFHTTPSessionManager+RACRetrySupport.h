//
//  AFHTTPSessionManager+RACRetrySupport.h
//
//  Created by Dal Rupnik on 10/14/14
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#if (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000) || (defined(__MAC_OS_X_VERSION_MAX_ALLOWED) && __MAC_OS_X_VERSION_MAX_ALLOWED >= 1090)

#import "RACURLSessionRetryDataTask.h"

@interface AFHTTPSessionManager (RACRetrySupport)

- (RACSignal *)rac_GET:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries;
- (RACSignal *)rac_GET:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval;
- (RACSignal *)rac_GET:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval test:(RACURLSessionRetryTestBlock)testBlock;

- (RACSignal *)rac_HEAD:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries;
- (RACSignal *)rac_HEAD:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval;
- (RACSignal *)rac_HEAD:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval test:(RACURLSessionRetryTestBlock)testBlock;

- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries;
- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval;
- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval test:(RACURLSessionRetryTestBlock)testBlock;

- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block retries:(NSInteger)retries;
- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block retries:(NSInteger)retries interval:(NSTimeInterval)interval;
- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block retries:(NSInteger)retries interval:(NSTimeInterval)interval test:(RACURLSessionRetryTestBlock)testBlock;

- (RACSignal *)rac_PUT:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries;
- (RACSignal *)rac_PUT:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval;
- (RACSignal *)rac_PUT:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval test:(RACURLSessionRetryTestBlock)testBlock;

- (RACSignal *)rac_PATCH:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries;
- (RACSignal *)rac_PATCH:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval;
- (RACSignal *)rac_PATCH:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval test:(RACURLSessionRetryTestBlock)testBlock;

- (RACSignal *)rac_DELETE:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries;
- (RACSignal *)rac_DELETE:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval;
- (RACSignal *)rac_DELETE:(NSString *)path parameters:(id)parameters retries:(NSInteger)retries interval:(NSTimeInterval)interval test:(RACURLSessionRetryTestBlock)testBlock;

@end

#endif