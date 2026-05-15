Pod::Spec.new do |s|
  s.name             = "nslib-security-ios"
  s.version          = "1.0.0"
  s.summary          = "Jailbreak detection utility library for iOS."
  s.description      = <<-DESC
  nslib-security-ios is a Swift library for detecting jailbreak signals
  on iOS devices.
  DESC
  s.homepage         = "https://github.com/nsshopping/nslib-security-ios"
  s.license          = { :type => "Proprietary", :text => "Copyright (c) nsshopping. All rights reserved." }
  s.author           = { "nsshopping" => "opensource@nsshopping.com" }
  s.source           = { :git => "https://github.com/nsshopping/nslib-security-ios.git", :tag => s.version.to_s }

  s.ios.deployment_target = "13.0"
  s.swift_versions   = ["5.9"]
  s.source_files     = "Sources/SecureUtility/**/*.swift"
  s.frameworks       = "UIKit"
end
