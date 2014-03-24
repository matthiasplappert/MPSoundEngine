#
# Be sure to run `pod spec lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "MPSoundEngine"
  s.version          = "1.0.0"
  s.summary          = "A simple engine that can synthesise sounds from a given frequency for mono or stereo output."
  s.description      = <<-DESC
                       An optional longer description of MPSoundEngine

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/matthiasplappert/MPSoundEngine"
  s.license          = "MIT"
  s.author           = { "Matthias Plappert" => "matthiasplappert@me.com" }
  s.source           = { :git => "https://github.com/matthiasplappert/MPSoundEngine.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/mplappert'

  # s.platform     = :ios, '5.0'
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'Classes'
  s.resources = 'Resources'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  s.frameworks = 'AudioToolbox'
end
