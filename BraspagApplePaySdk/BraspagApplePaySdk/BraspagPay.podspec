
Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name         = "BraspagApplePay"
  s.version      = "1.0.0"
  s.summary      = "BraspagApplePay is the easiest way to get Apple Pay into your app."
  s.description  = <<-DESC
                    The easiest way to get Apple Pay into your app 💳. That library will keep you focused at only the right things.
                   DESC
  s.homepage     = "https://github.com/BraspagDevelopers/braspag-apple-pay"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = { :type => "MIT" }
  s.author             = { "Jeferson F. Nazario" => "jefnazario@gmail.com" }
  s.social_media_url   = "http://twitter.com/jefnazario"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source       = { :git => "https://github.com/BraspagDevelopers/braspag-apple-pay.git", :tag => "#{s.version}" }
  s.ios.deployment_target = '11.0'


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source_files  = "Classes", "${POD_NAME}/Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
end
