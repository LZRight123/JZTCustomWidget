#
# Be sure to run `pod lib lint JZTPerformanceMonitor.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JZTCustomWidget'
  s.version          = '1.0.4'
  s.summary          = 'JZTCustomWidget. 自定义组件，工具，转场动画'
  s.homepage         = 'https://github.com/LZRight123/JZTCustomWidget.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '350442340@qq.com' => '350442340@qq.com' }
  s.source           = { :git => 'https://github.com/LZRight123/JZTCustomWidget.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'

  s.source_files = 'JZTCustomWidget/**/*.{h,m}'
  #s.resource = 'JZTCustomWidget/JZTCustomWidget.bundle'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.dependency 'Masonry'
  s.requires_arc = true
end
