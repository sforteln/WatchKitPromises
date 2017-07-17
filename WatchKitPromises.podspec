Pod::Spec.new do |s|
  s.name             = "WatchKitPromises"
  s.version          = "0.2.2"
  s.summary          = "A library to add PromiseKit support to WatchKit."
  s.description      = <<-DESC
                       Adds support for WatchKit animations to WatchKit

                       DESC
  s.homepage         = "https://github.com/sforteln/WatchKitPromises"
  s.license          = 'MIT'
  s.author           = { "Simon Fortelny" => "sforteln@gmail.com" }
  s.source           = { :git => "https://github.com/sforteln/WatchKitPromises.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/simonfort'
  s.platform     = :watchos, '2.0'
  s.watchos.deployment_target = '2.0'
  s.requires_arc = true
  s.source_files = 'Source/**/*.{swift}'
  s.frameworks       = 'WatchKit'
  s.dependency 'PromiseKit','~> 4.2'
end
