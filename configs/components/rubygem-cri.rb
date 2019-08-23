component "rubygem-cri" do |pkg, settings, platform|
  pkg.version "2.15.9"
  pkg.md5sum "9f0a7ab99296f0bef5fe1a0fe703b41b"
  pkg.url "#{settings[:buildsources_url]}/cri-#{pkg.get_version}.gem"

  pkg.build_requires "pdk-runtime"

  if platform.is_windows?
    pkg.environment "PATH", settings[:gem_path_env]
  end

  pkg.install do
    "#{settings[:gem_install]} cri-#{pkg.get_version}.gem"
  end
end
