module AppDynamicsCookbook
  module Helpers
    def platform(family, supported)
      plat = family

      case family
      when 'mac_os_x'
        plat = 'osx'
      when 'GNU/Linux'
        plat = 'linux'
      end

      raise "Unsupported OS family #{plat}" if supported and not supported.include? plat

      plat
    end

    def architecture(machine, supported)
      arch = machine

      case arch
      when 'i386'
        arch = 'x86'
      when 'x86_64'
        arch = 'x64'
      end

      raise "Unsupported CPU architecture" if supported and not supported.include? arch

      arch
    end
  end
end
