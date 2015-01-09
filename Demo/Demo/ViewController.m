//
//  ViewController.m
//  Demo
//
//  Created by Dal Rupnik on 08/01/15.
//  Copyright (c) 2015 arvystate.net. All rights reserved.
//

#import <AFHTTPSessionManager+RACRetrySupport.h>

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    

    RACSignal *sig1 = [manager rac_GET:@"http://www.google.com" parameters:nil retries:3 interval:5.0];
    
    RACSignal *sig2 = [manager rac_GET:@"http://www.yahoo.com" parameters:nil retries:3];
    
    RACSignal *sig3 = [manager rac_GET:@"http://www.arvystate.net" parameters:nil retries:3];
    
    RACSignal *sig4 = [manager rac_GET:@"http://www.facebook.com" parameters:nil retries:3];
    
    RACSignal *combined = [sig1 then:^RACSignal *{
        return [sig2 then:^RACSignal *{
            return [sig3 then:^RACSignal *{
                return sig4;
            }];
        }];
    }];
    //
    // No code was executed up to this point
    //
    
    [combined subscribeNext:^(NSNumber* x) {
        NSLog(@"Success: %@", [x class]);
    } error:^(NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
    } completed:^{
        NSLog(@"Completed.");
    }];
    /*
    
    [[manager rac_GET:@"http://www.google.com" parameters:nil retries:3 interval:5.0 test:^BOOL(NSURLResponse *response, id responseObject, NSError *error)
     {
         id resp = response;
         
         return [resp statusCode] != 404;
     }] subscribeNext:^(id x) {
         NSLog(@"3: Success.");
     } error:^(NSError *error) {
         NSLog(@"3: Error: %@", error.localizedDescription);
     } completed:^{
         NSLog(@"3: Finished.");
     }];*/
}

@end
