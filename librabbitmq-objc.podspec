Pod::Spec.new do |spec|
  spec.name     = 'librabbitmq-objc'
  spec.version  = '1.0.0'
  spec.summary  = 'Objective-C wrapper for librabbitmq-c'
  spec.homepage = "https://prof-maad.org"
  spec.license  = { :type => 'LGPL3v3', :file => 'LICENSE' }
  spec.author   = "Prof. MAAD"

  spec.platform = :ios
  spec.ios.deployment_target = '6.0'
  
  spec.homepage       = 'https://github.com/albertodebortoli/librabbitmq-objc'
  spec.preserve_paths = 'rabbitmq-c/0.5.0/librabbitmq.a'
  spec.source         = { :git => 'git@github.com:albertodebortoli/librabbitmq-objc.git', :tag => "#{spec.version}" }
  spec.source_files   = '*.{h,m}', 'rabbitmq-c/0.5.0/*.h'
  spec.xcconfig       = { 'LIBRARY_SEARCH_PATHS' => "\"$(SRCROOT)/Pods/librabbitmq-objc/rabbitmq-c/0.5.0/\"" }
  spec.libraries      = 'rabbitmq'
  spec.requires_arc   = false
end
