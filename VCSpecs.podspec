Pod::Spec.new do |s|
  s.name         = "VCSpecs"
  s.version      = "1.0.0"
  s.summary      = "A swift View Controller testing framework"

  s.description  = <<-DESC
                   Quick is a behavior-driven development framework for Swift and Objective-C. Inspired by Quick.
                   DESC

  s.homepage     = "https://github.com/blladnar/VCSpecs"
  s.license      = { :type => "Apache 2.0", :file => "LICENSE" }

  s.author       = "Quick Contributors"
  s.ios.deployment_target = "10.1"

  s.source       = { :git => "https://github.com/blladnar/VCSpecs.git", :tag => "v#{s.version}" }
  s.source_files = "VCSpecs/*.{swift,h,m}"

  s.public_header_files = [
    'VCSpecs/VCSpec.h',
    'VCSpecs/VCSpecs.h',
  ]

  s.framework = "XCTest"
  s.requires_arc = true
  s.user_target_xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(PLATFORM_DIR)/Developer/Library/Frameworks' }
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
end
