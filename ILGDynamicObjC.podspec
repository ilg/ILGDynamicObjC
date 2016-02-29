Pod::Spec.new do |s|
  s.name             = "ILGDynamicObjC"
  s.version          = "0.2.0"
  s.summary          = "Helpers for using Objective-C's dynamic runtime features."
  s.homepage         = "https://github.com/ilg/ILGDynamicObjC"
  s.license          = 'MIT'
  s.author           = { "Isaac Greenspan" => "ilg@2718.us" }
  s.source           = { :git => "https://github.com/ilg/ILGDynamicObjC.git", :tag => s.version.to_s }

  s.requires_arc = true

  s.subspec 'ILGSwizzler' do |ss|
      ss.source_files = 'Pod/ILGSwizzler/*.{h,m}'
  end
  
  s.subspec 'ILGClasses' do |ss|
      ss.source_files = 'Pod/ILGClasses/*.{h,m}'
  end
end
