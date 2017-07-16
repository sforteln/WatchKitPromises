Pod::Spec.new do |s|
  s.name             = "WatchKitPromises"
  s.version          = "0.1.0"
  s.summary          = "A library to add PromiseKit Promises to WatchKit."
  s.description      = <<-DESC
                       A library to simply zoom in and out a UIView.  It has a default animation similar to UIAlertView and allows for custom anitmation keyframes.

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
