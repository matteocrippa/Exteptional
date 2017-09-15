Pod::Spec.new do |s|
  s.name             = 'Exteptional'
  s.version          = '0.2.6'
  s.summary          = 'An EXTeptional collections of extensions.'

  s.description      = <<-DESC
A collection of exceptional extension easy to use in your Swift based projects.
                       DESC

  s.homepage         = 'https://github.com/matteocrippa/Exteptional'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'matteocrippa' => '@_ghego' }
  s.source           = { :git => 'https://github.com/matteocrippa/Exteptional.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/_ghego'

  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'

  s.source_files = 'Exteptional/Classes/**/*'
end
