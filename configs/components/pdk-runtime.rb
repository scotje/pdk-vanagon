component 'pdk-runtime' do |pkg, settings, platform|
  #pkg.version settings[:pdk_runtime_version]
  #pkg.sha1sum "http://builds.puppetlabs.lan/puppet-runtime/#{pkg.get_version}/artifacts/#{pkg.get_name}-#{pkg.get_version}.#{platform.name}.tar.gz.sha1"
  #pkg.url "http://builds.puppetlabs.lan/puppet-runtime/#{pkg.get_version}/artifacts/#{pkg.get_name}-#{pkg.get_version}.#{platform.name}.tar.gz"
  pkg.version "201804040.604.ged404fa"
  pkg.sha1sum "http://builds.delivery.puppetlabs.net/puppet-runtime/ed404fae7588bbadab1b64d29dd6454d719ebefd/artifacts/#{pkg.get_name}-#{pkg.get_version}.#{platform.name}.tar.gz.sha1"
  pkg.url "http://builds.delivery.puppetlabs.net/puppet-runtime/ed404fae7588bbadab1b64d29dd6454d719ebefd/artifacts/#{pkg.get_name}-#{pkg.get_version}.#{platform.name}.tar.gz"
  pkg.install_only true

  install_commands = ["gunzip -c #{pkg.get_name}-#{pkg.get_version}.#{platform.name}.tar.gz | tar -C / -xf -"]

  if platform.is_windows?
    # We need to make sure we're setting permissions correctly for the executables
    # in the ruby bindir since preserving permissions in archives in windows is
    # ... weird, and we need to be able to use cygwin environment variable use
    # so cmd.exe was not working as expected.
    install_commands = [
      "gunzip -c #{pkg.get_name}-#{pkg.get_version}.#{platform.name}.tar.gz | tar -C /cygdrive/c/ -xf -",
      "chmod 755 #{settings[:ruby_bindir].sub(/C:/, '/cygdrive/c')}/*"
    ]

    settings[:additional_rubies].each do |rubyver, local_settings|
      install_commands << "chmod 755 #{local_settings[:ruby_bindir].sub(/C:/, '/cygdrive/c')}/*"
    end
  end

  # Clean up uneccesary files.
  install_commands << "rm -rf /opt/puppetlabs/pdk/bin/*"
  install_commands << "rm -rf /opt/puppetlabs/pdk/share/vim"
  install_commands << "rm -rf /opt/puppetlabs/pdk/share/aclocal"
  install_commands << "rm -rf /opt/puppetlabs/pdk/share/man"
  install_commands << "rm -rf /opt/puppetlabs/pdk/share/doc"
  install_commands << "rm -rf /opt/puppetlabs/pdk/share/augeas"
  install_commands << "rm -rf /opt/puppetlabs/pdk/ssl/misc"
  install_commands << "rm -rf /opt/puppetlabs/pdk/ssl/man"

  pkg.install do
    install_commands
  end
end
