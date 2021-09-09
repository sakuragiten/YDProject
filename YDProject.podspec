#
# Be sure to run `pod lib lint YDProject.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YDProject'
  s.version          = '0.1.1'
  s.summary          = 'A short description of YDProject.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/SakuragiTen/YDProject.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Viktor' => 'gongs@dachentech.com.cn' }
  s.source           = { :git => 'https://github.com/SakuragiTen/YDProject.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.3'

  s.source_files = 'YDProject/Classes/**/*'
  
  # s.resource_bundles = {
  #   'YDProject' => ['YDProject/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking', '~> 3.1'
#s.dependency 'ReactiveCocoa'

#  swift
  s.dependency 'RxSwift',    '~> 4.0'
  s.dependency 'RxCocoa',    '~> 4.0'
  s.dependency 'SnapKit'
  
    s.prefix_header_contents = <<-EOS

    #import "YDMacro.h"
    #import "YDHeader.h"
    EOS
end
