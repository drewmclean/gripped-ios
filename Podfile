# Uncomment this line to define a global platform for your project
platform :ios, '10.0'
swift_version = '3.0'

target 'GrippedAthletics' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  pod 'PromiseKit', '~> 4.0.5'
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
  pod 'Firebase/Crash'
  pod 'AWSCore', '~> 2.4'
  pod 'AWSCognito', '~> 2.4'
  pod 'FacebookCore', '~> 0.2'g
  pod 'FacebookLogin', '~> 0.2'
  pod 'PKRevealController'
  pod 'Locksmith'
  pod 'SnapKit'`
  
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
