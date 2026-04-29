#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'location_tracking'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin for getting location updates even when the app is killed.'
  s.description      = <<-DESC
A new Flutter plugin.
                       DESC
  s.homepage         = 'https://github.com/sombathdanet/location-tracking'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Sombathdanet' => 'sombatdanet@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.ios.deployment_target = '12.0'
end
