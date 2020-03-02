platform :ios, '11.0'
inhibit_all_warnings!
use_modular_headers!

def common_pods
    pod 'SwiftLint', '~> 0.39.1'
    pod 'Alamofire', '~> 5.0.2'
end

target 'MPCRemote' do
    common_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '5.0'
        end
    end
end

ENV['COCOAPODS_DISABLE_STATS'] = 'true'
