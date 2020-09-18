#
#  Be sure to run `pod spec lint DPColorfulTags.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "DPColorfulTags"
  s.version      = "0.1.4"
  s.summary      = "colorful tags"

  s.description  = <<-DESC
                    Tags with different colors in UITableview. Tags can be selected.
                    DESC

  s.homepage     = "https://github.com/HongliYu/DPColorfulTags-Swift"
  s.license      = "MIT"
  s.author       = { "HongliYu" => "yhlssdone@gmail.com" }
  s.source       = { :git => "https://github.com/HongliYu/DPColorfulTags-Swift.git", :tag => "#{s.version}" }
  s.source_files = "Sources/DPColorfulTags-Swift/*.{swift}"
  s.resources = ['Sources/DPColorfulTags-Swift/*.{xib}']
  s.platform     = :ios, "12.0"
  s.requires_arc = true
  s.frameworks   = 'UIKit'
  s.module_name  = 'DPColorfulTags'
  s.swift_version = "5.0"

end
