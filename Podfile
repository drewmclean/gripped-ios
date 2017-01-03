
platform :ios, '10.0'
swift_version = '3.0'

target 'GrippedAthletics' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  pod 'CocoaLumberjack/Swift'
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
  pod 'Firebase/Crash'
  pod 'FacebookCore', '~> 0.2'
  pod 'FacebookLogin', '~> 0.2'
  pod 'BrightFutures', '~> 5.0'
  pod 'FutureProofing', :git => 'git@github.com:Thomvis/FutureProofing.git'
  pod 'PKRevealController'
  pod 'Locksmith'
  pod 'SnapKit'
  pod 'SwiftValidator', :git => 'https://github.com/jpotts18/SwiftValidator.git', :branch => 'master'
  pod 'SDWebImage', :git => 'git@github.com:rs/SDWebImage.git', :branch => '4.x'
  
  # Pods for GrippedAthletics
  
  target 'GrippedAthleticsTests' do
    inherit! :search_paths
    
  end

  target 'GrippedAthleticsUITests' do
    inherit! :search_paths
    # Pods for testing
  end

    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.0'
            end
        end
    end

end
