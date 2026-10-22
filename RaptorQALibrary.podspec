Pod::Spec.new do |s|
  s.name         = 'RaptorQALibrary'
  s.version      = '1.0.11'
  s.summary      = 'In-app QA reporting SDK for iOS applications.'
  s.description  = <<-DESC
    RaptorQALibrary provides in-app QA reporting capabilities
    for iOS applications using the RaptorQA service.
  DESC

  s.homepage     = 'https://raptorqa.com'
  s.license      = {
    :type => 'Commercial',
    :file => 'LICENSE.md'
  }
  s.author       = {
    'BConnect Software LLC' => 'support@raptorqa.com'
  }

  s.platform     = :ios, '15.0'
  s.source       = {
    :git => 'https://github.com/BConnectSoftware/RaptorQASwift_Library.git',
    :tag => s.version.to_s
  }

  s.vendored_frameworks = 'Frameworks/RaptorQALibrary.xcframework'
  s.requires_arc = true
end
