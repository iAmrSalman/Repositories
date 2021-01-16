platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

def testing_pods
  pod 'Quick'
  pod 'Nimble'
  pod 'RxBlocking'
  pod 'RxTest'
  pod 'PromiseKit'
end

def app_essential_pods
  pod 'R.swift'
  pod 'Kingfisher'
end

def ui_essential_pods
  pod 'RxCocoa'
  pod 'SnapKit'
end

def shared_pods
  pod 'RxSwift'
end

def core_essential_pods
  pod 'PromiseKit'
  pod 'Moya'
  pod 'RxRelay'
end

target 'App_iOS' do
  ui_essential_pods
  app_essential_pods
  shared_pods
end

target 'AppUIKit' do
  ui_essential_pods
  shared_pods
end

target 'CoreKit' do
  core_essential_pods
  shared_pods
  target 'CoreKitTests' do
    testing_pods
  end

end

target 'Repositories' do

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
