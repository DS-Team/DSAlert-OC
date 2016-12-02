Pod::Spec.new do |s|
    s.name         = "DSAlert-OC"
    s.version      = "1.0.1"
    s.summary      = '目前为止，最为精简的 alert 和 actionSheet 封装！DSAlert 让你的弹框不再孤单！'
    s.homepage     = 'https://github.com/DS-Team/DSAlert-OC'
    s.license      = 'MIT'
    s.authors      = { 'DS-Team' => '513878863@qq.com' }
    s.platform     = :ios, '7.0'
    s.source       = { :git => 'https://github.com/DS-Team/DSAlert-OC.git', :tag => s.version.to_s }
    s.source_files = 'DSAlert-OC/DSAlert/*.{h,m}'
    s.requires_arc = true
end
