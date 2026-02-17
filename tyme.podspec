Pod::Spec.new do |spec|
  spec.name         = "tyme"
  spec.version      = "1.4.2"
  spec.summary      = "A powerful Chinese calendar library for iOS, macOS, tvOS, and watchOS"
  
  spec.description  = <<-DESC
    tyme4swift is a complete Swift implementation of the Tyme library,
    supporting solar calendar, lunar calendar, Tibetan calendar, 
    24 solar terms, zodiac signs, heavenly stems & earthly branches,
    eight characters (八字), nine stars (九星), pengzu taboos (彭祖百忌),
    and much more.
    
    Core Features:
    - Solar, Lunar, and Tibetan calendars
    - 24 Solar terms (节气)
    - Zodiac signs (生肖)
    - Heavenly Stems & Earthly Branches (天干地支)
    - Eight Characters system (八字)
    - Nine Stars system (九星)
    - Pengzu Taboos (彭祖百忌)
    - Deity systems and festival calendars
    - Complete astronomical calculations
  DESC

  spec.homepage     = "https://github.com/xuanyunhui/tyme4swift"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "xuanyunhui" => "xuanyunhui@icloud.com" }
  spec.source       = { :git => "https://github.com/xuanyunhui/tyme4swift.git", :tag => "v#{spec.version}" }

  # Platform requirements
  spec.ios.deployment_target     = "13.0"
  spec.macos.deployment_target   = "10.15"
  spec.tvos.deployment_target    = "13.0"
  spec.watchos.deployment_target = "6.0"

  # Source files
  spec.source_files = "Sources/**/*.swift"
  
  # Swift version
  spec.swift_version = "5.5"
  
  # Documentation
  spec.documentation_url = "https://github.com/xuanyunhui/tyme4swift"

  # Social media
  spec.social_media_url = "https://github.com/xuanyunhui/tyme4swift"
end
