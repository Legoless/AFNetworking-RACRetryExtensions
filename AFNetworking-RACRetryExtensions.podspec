Pod::Spec.new do |s|
  s.name         = "AFNetworking-RACRetryExtensions"
  s.version      = "0.2.0"
  s.summary      = "AFNetworking-RACRetryExtensions is an extension to the AFNetworking classes for iOS and Mac OS X that adds the auto-retry ability."
  s.homepage     = "https://github.com/legoless/AFNetworking-RACRetryExtensions"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Dal Rupnik" => "legoless@gmail.com" }
  s.source       = { :git => "https://github.com/legoless/AFNetworking-RACRetryExtensions.git", :tag => "#{s.version}" }
  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'
  s.source_files = 'RACRetryExtensions/*.{h,m}'
  s.requires_arc = true
  s.dependency 'AFNetworking', '~> 2.x'
  s.dependency 'ReactiveCocoa', '~> 2.x'
end