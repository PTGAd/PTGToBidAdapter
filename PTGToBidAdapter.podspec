Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "PTGToBidAdapter"
  spec.version      = "2.3.10.0"
  spec.summary      = "PTGToBidAdapter is a mediation adapter for ToBid SDK."


  spec.description  = <<-DESC
    PTGAdFramework provides Union ADs which include native, banner, feed, splash, RewardVideo etc. This adapter allows PTGAdFramework to work with ToBid SDK.
  DESC

  spec.homepage     = "https://github.com/PTGAd/PTGToBidAdapter"

  spec.license      = { :type => "MIT", :file => "LICENSE" }


  spec.author             = { "fancy" => "ptg_all@fancydigital.com.cn" }

  spec.source       = { :git => "https://github.com/PTGAd/PTGToBidAdapter.git", :tag => "#{spec.version }" }


  spec.platform     = :ios, "12.0"
  spec.frameworks = 'UIKit', 'MapKit', 'WebKit', 'MediaPlayer', 'AdSupport', 'CoreMedia', 'AVFoundation', 'CoreTelephony', 'StoreKit', 'SystemConfiguration', 'MobileCoreServices', 'CoreMotion', 'Accelerate', 'CoreGraphics', 'Security', 'CoreAudioTypes'
  spec.libraries = 'c++', 'resolv', 'z', 'sqlite3'
  spec.vendored_frameworks =  'Frameworks/PTGToBidAdapter.framework'
  spec.dependency 'PTGAdFramework'
  spec.dependency 'WindMillSDK'
  spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

end
