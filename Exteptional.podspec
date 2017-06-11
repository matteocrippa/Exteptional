#
# Be sure to run `pod lib lint Exteptional.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Exteptional'
  s.version          = '0.1.1'
  s.summary          = 'An EXTeptional collections of extensions.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A collection of exceptional extension easy to use in your Swift based projects.
                       DESC

  s.homepage         = 'https://github.com/matteocrippa/Exteptional'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'matteocrippa' => '@_ghego' }
  s.source           = { :git => 'https://github.com/matteocrippa/Exteptional.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/_ghego'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Exteptional/Classes/**/*'
end
