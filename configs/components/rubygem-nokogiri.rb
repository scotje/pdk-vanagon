component 'rubygem-nokogiri' do |pkg, settings, platform|
  gemname = pkg.get_name.gsub('rubygem-', '')
  pkg.version settings[:nokogiri_version]
  pkg.md5sum "6213c2464766cbc5cc54253cbfc53d81"
  pkg.url "http://rubygems.org/downloads/#{gemname}-#{pkg.get_version}.gem"

  pkg.build_requires "pdk-runtime"
  pkg.build_requires 'rubygem-mini_portile2'

  if platform.is_windows?
    pkg.environment 'PATH', settings[:gem_path_env]
    pkg.url "#{settings[:buildsources_url]}/#{gemname}-#{pkg.get_version}-x64-mingw32.gem"
    pkg.md5sum "ba21ce721b6ae696b55b8e8d164cdb27"

    pkg.install do
      ["#{settings[:gem_install]} #{gemname}-#{pkg.get_version}-x64-mingw32.gem"]
    end
    pkg.build_requires "pl-zlib-#{platform.architecture}"
  else
    pkg.build_requires 'cmake'

    if platform.is_rpm?
      # red hat
      pkg.build_requires 'pkgconfig'
    else
      # debian
      pkg.build_requires 'pkg-config'
    end

    if platform.is_deb?
      pkg.build_requires "zlib1g-dev"
    elsif platform.is_aix?
      pkg.build_requires "http://osmirror.delivery.puppetlabs.net/AIX_MIRROR/zlib-devel-1.2.3-4.aix5.2.ppc.rpm"
    elsif platform.is_rpm?
      pkg.build_requires "zlib-devel"
    end

    pkg.install do
      ["#{settings[:gem_install]} #{gemname}-#{pkg.get_version}.gem"]
    end
  end
end
