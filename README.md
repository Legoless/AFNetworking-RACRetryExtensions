# AFNetworking - RACRetryExtensions
AFNetworking 2.0 extensions to add ReactiveCocoa support with automatic retry based on a special condition (timeout or similar). Retry condition can be set as a block, also based on HTTP status code.

Only extends AFHTTPSessionManager for now. For each HTTP operation a RACSignal is returned. Under the hood, multiple calls are made to desired API and only after final retry the operation is errored.

For specific retry logic, a block can be provided into the method, which will be evaluated on each retry.

## License

[MIT License](https://github.com/Legoless/AFNetworking-RACRetryExtensions/blob/master/LICENSE)
