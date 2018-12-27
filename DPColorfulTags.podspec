#
#  Be sure to run `pod spec lint DPColorfulTags.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "DPColorfulTags"
  s.version      = "0.1.0"
  s.summary      = "colorful tags"

  s.description  = <<-DESC
                    Tags with different colors in UITableview. Tags can be selected.
                    DESC

  s.homepage     = "https://github.com/HongliYu/DPColorfulTags-Swift"
  s.license      = "MIT"
  s.author       = { "HongliYu" => "yhlssdone@gmail.com" }
  s.source       = { :git => "https://github.com/HongliYu/DPColorfulTags-Swift.git", :tag => "#{s.version}" }

  s.platform     = :ios, "10.0"
  s.requires_arc = true
  s.source_files = "DPColorfulTagsDemo/DPColorfulTags/*.swift", "DPColorfulTagsDemo/DPColorfulTags/*.xib"
  s.frameworks   = 'UIKit'
  s.module_name  = 'DPColorfulTags'
  s.swift_version = "4.2"

end
