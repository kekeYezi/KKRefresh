
Pod::Spec.new do |s|
  s.name             = 'KKRefresh'
  s.version          = '0.1.0'
  s.summary          = 'KKRefresh is post-packaging to the MJRefresh'
  s.description      =  "use for self"

  s.homepage         = 'https://github.com/kekeYezi/KKRefresh.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Keke' => 'kekeyezi1992@163.com' }
  s.source           = { :git => 'https://github.com/kekeYezi/KKRefresh.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'KKRefresh/Classes/**/*'
  
  # s.resource_bundles = {
  #   'KKRefresh' => ['KKRefresh/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.resource = 'KKRefresh/Assets/KKRefresh.bundle'
  s.dependency 'MJRefresh',         '~>3.1.15'
  s.dependency 'DZNEmptyDataSet',   '~>1.8.1'
end
