Pod::Spec.new do |s|
  s.name    = 'ZWPhotoPreview'
  s.version = '0.2.1'
  s.summary = '简单易用的图片预览器。支持左右滑动查看图片、手势拖动取消动画、图片单击隐藏、双击放大、长按保存。支持UIImage、URLString格式。支持显示标题、文本、页码。'
  s.homepage  = 'https://github.com/wangziwu/ZWPreviewImage'
  s.license = 'MIT'
  s.authors = {'wangziwu' =>  'wang_ziwu@126.com'}
  s.platform  = :ios,'8.0'
  s.ios.deployment_target = '8.0'
  s.source  = {:git => 'https://github.com/wangziwu/ZWPreviewImage.git',:tag => s.version}
  s.source_files  = 'ZWPhotoPreview/*.{h,m}'
  s.requires_arc  = true
  s.dependency      'SDWebImage',       '~> 4.4.0'
end