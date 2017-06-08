Pod::Spec.new do |s|

  s.name    = 'ZWPreviewImage'
  s.version = '0.0.1'
  s.summary = '简单易用的图片预览器。左右滑动查看图片，支持UIImage、URLString。'
  s.homepage  = 'https://github.com/wangziwu/ZWPreviewImage'
  s.license = 'MIT'
  s.authors = {'wangziwu' =>  'wang_ziwu@126.com'}
  s.platform  = :ios,'8.0'
  s.ios.deployment_target = '8.0'
  s.source  = {:git => 'https://github.com/wangziwu/ZWPreviewImage.git',:tag => s.version}
  s.source_files  = 'ZWPreviewImage/*.{h,m}'
  s.requires_arc  = true
  s.dependency 'SDWebImage',  '~> 4.0.0'
  s.dependency 'ZWFrame',     '~> 0.0.2'
end
