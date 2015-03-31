# AFNetworking - RACRetryExtensions
[![Build Status](http://img.shields.io/travis/legoless/AFNetworking-RACRetryExtensions/master.svg?style=flat)](https://travis-ci.org/legoless/AFNetworking-RACRetryExtensions)
[![Pod Version](http://img.shields.io/cocoapods/v/AFNetworking-RACRetryExtensions.svg?style=flat)](http://cocoadocs.org/docsets/AFNetworking-RACRetryExtensions/)
[![Pod Platform](http://img.shields.io/cocoapods/p/AFNetworking-RACRetryExtensions.svg?style=flat)](http://cocoadocs.org/docsets/AFNetworking-RACRetryExtensions/)
[![Pod License](http://img.shields.io/cocoapods/l/AFNetworking-RACRetryExtensions.svg?style=flat)](http://opensource.org/licenses/MIT)

AFNetworking 2.0 extensions to add `ReactiveCocoa` support with automatic retry based on a special condition (timeout or similar). Retry condition can be set as a block, also based on HTTP status code.

Only extends `AFHTTPSessionManager` for now with Reactive methods. For each HTTP operation a `RACSignal` is returned. Under the hood, multiple calls are made to desired API and only after final retry the operation is errored.

For specific retry logic, a test block can be provided into the method, which will be evaluated on each retry. If operation returns `YES`, the request is retried.

## Install

The easiest way to install is with [CocoaPods](http://cocoapods.org) by specifying the pod in **Podfile**.

```
pod 'AFNetworking-RACRetryExtensions'
```

Alternatively you can download the .zip of the project and drag and drop files into your project (the manual way).

## Usage

**RACRetryExtensions** provide a category to `AFHTTPSessionManager` with multiple convenience methods that return an  `RACSignal` wrapped `RACURLSessionRetryDataTask`. Methods provide different configuration options, such as: number of retries before failing, sleep delay before next retry and retry test block. First two parameters correspond to AFNetworking `AFHTTPSessionManager` HTTP method and parameters.

Example of a HTTP **GET** method that connects to a simple website.

```objc
AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];

RACSignal* getSignal = [manager rac_GET:@"http://example.org" parameters:nil retries:3 interval:10.0];

// Subscribe to signal to start request
[getSignal subscribeNext:^(id responseObject) {
    // Handle object
} error:^(NSError *error) {
    // Handle error
}];
```

*If the request fails from any reason, it will be retries 3 times. Before each retry attempt, task will wait for **10 seconds** before retrying.* Next block is called when response object is successfully received and error handler is called when all retries have exhausted. Error provided to the block is the error received on last retry. 

In certain cases we do not wish to retry in every case, but in case of bad network connection or certain server state. The code below uses a custom retry block that will retry, if HTTP response status code is 5xx.

```objc
AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];

RACSignal* getSignal = [manager rac_GET:@"http://example.org" parameters:nil retries:3 interval:10.0 test:^BOOL(NSHTTPURLResponse *response, id responseObject, NSError *error)
{
    if (response.statusCode >= 500)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}];

// Subscribe to signal to start request
[getSignal subscribeNext:^(id responseObject) {
    // Handle object
} error:^(NSError *error) {
    // Handle error
}];
```

Contact
======

Dal Rupnik

- [legoless](https://github.com/legoless) on **GitHub**
- [@thelegoless](https://twitter.com/thelegoless) on **Twitter**
- [legoless@arvystate.net](mailto:legoless@arvystate.net)

License
======

[MIT License](https://github.com/Legoless/AFNetworking-RACRetryExtensions/blob/master/LICENSE)
