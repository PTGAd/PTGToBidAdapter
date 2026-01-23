Pod::Spec.new do |s|

  s.name         = "PTGToBidAdapter"
  s.version      = "2.3.10.0"
  s.summary      = "PTG mediation adapter for ToBid SDK."
  s.description  = <<-DESC
PTGToBidAdapter is a mediation adapter that enables PTGAdFramework
to integrate with the ToBid advertising SDK.
  DESC

  s.homepage     = "https://github.com/PTGAd/PTGToBidAdapter"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "fancy" => "ptg_all@fancydigital.com.cn" }

  s.source       = {
    :git => "https://github.com/PTGAd/PTGToBidAdapter.git",
    :tag => s.version.to_s
  }

  # 🚨 必须 ≥ 12
  s.platform = :ios, "12.0"

  # ✅ adapter + vendored framework，必须 static
  s.static_framework = true

  s.vendored_frameworks = "Frameworks/PTGToBidAdapter.framework"

  s.frameworks = [
    "UIKit",
    "WebKit",
    "MediaPlayer",
    "AdSupport",
    "CoreMedia",
    "AVFoundation",
    "CoreTelephony",
    "StoreKit",
    "SystemConfiguration",
    "MobileCoreServices",
    "CoreMotion",
    "Accelerate",
    "CoreGraphics",
    "Security",
    "CoreAudioTypes"
  ]

  s.libraries = "c++", "resolv", "z", "sqlite3"

  # 🚨 强制所有 Pod target 使用 iOS 12
  s.pod_target_xcconfig = {
    "IPHONEOS_DEPLOYMENT_TARGET" => "12.0",
    "EXCLUDED_ARCHS[sdk=iphonesimulator*]" => "arm64"
  }

  s.user_target_xcconfig = {
    "EXCLUDED_ARCHS[sdk=iphonesimulator*]" => "arm64"
  }

  # ✅ 明确依赖范围，防止拉到老版本
  s.dependency "PTGAdFramework", ">= 2.3.1"
  s.dependency "ToBid-iOS", ">= 4.7.0"

end