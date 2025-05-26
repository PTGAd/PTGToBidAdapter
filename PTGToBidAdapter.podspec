Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "PTGToBidAdapter"
  spec.version      = "2.2.72.0"
  spec.summary      = "A short description of PTGToBidAdapter."


  spec.description  = <<-DESC
    PTGAdFramework provides Union ADs which include native、banner、feed、splash、RewardVideo etc.
  DESC

  spec.homepage     = "https://github.com/PTGAd/PTGToBidAdapter"

  spec.license      = "MIT"


  spec.author             = { "fancy" => "ptg_all@fancydigital.com.cn" }

  spec.source       = { :git => "https://github.com/PTGAd/PTGToBidAdapter", :tag => "#{spec.version }" }


  spec.platform     = :ios, "11.0"
  spec.frameworks = 'UIKit', 'MapKit', 'WebKit', 'MediaPlayer', 'AdSupport', 'CoreMedia', 'AVFoundation', 'CoreTelephony', 'StoreKit', 'SystemConfiguration', 'MobileCoreServices', 'CoreMotion', 'Accelerate', 'CoreGraphics', 'Security'
  spec.libraries = 'c++', 'resolv', 'z', 'sqlite3'
  spec.vendored_frameworks =  'Frameworks/PTGToBidAdapter.framework'
  valid_archs = ['armv7', 'armv7s', 'x86_64', 'arm64']
  spec.xcconfig = {
    'VALID_ARCHS' =>  valid_archs.join(' '),
  }

end
