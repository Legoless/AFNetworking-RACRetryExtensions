# AFNetworking - RACRetryExtensions
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


Contact
======

Dal Rupnik

- [legoless](https://github.com/legoless) on **GitHub**
- [@thelegoless](https://twitter.com/thelegoless) on **Twitter**
- [legoless@arvystate.net](mailto:legoless@arvystate.net)

License
======

[MIT License](https://github.com/Legoless/AFNetworking-RACRetryExtensions/blob/master/LICENSE)
