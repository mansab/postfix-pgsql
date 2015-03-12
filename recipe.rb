# class Postfix < FPM::Cookery::Recipe
# AUTHOR Mansab Uppal
# Official site: http://mansab.upp.al
# Official git repository: https://github.com/mansab/postfix-pgsql
# License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.
# See README.md for more information.
# 
class Postfix < FPM::Cookery::Recipe
  description 'Postfix is a Mail Transport Agent (MTA), supporting LDAP, SMTP AUTH (SASL),TLS with additional support for pgsql'

  name     'postfix'
  version  ENV['BUILD_VERSION'] || '2:2.11.1'
  revision ENV['BUILD_REV'] || '0.el7'
  homepage 'http://www.postfix.org/'
  source   "http://de.postfix.org/ftpmirror/official/postfix-#{version.split(':')[1] || version.split(':')[0]}.tar.gz"

  arch     'x86_64'

  section  'mail server'

  build_depends 'libdb'
  build_depends 'libdb-devel'
  build_depends 'gcc'
  build_depends 'openssl'
  build_depends 'openssl-devel'
  build_depends 'pcre'
  build_depends 'pcre-devel'
  build_depends 'openldap-devel'
  build_depends 'cyrus-sasl'
  build_depends 'cyrus-sasl-devel'
  build_depends 'openldap'
  build_depends 'postgresql-devel'

  post_install   './post-install'
  post_uninstall './post-uninstall'
  pre_install    './pre-install'
  pre_uninstall  './pre-uninstall'

  def build

    inline_replace 'postfix-install' do |s|
      s.gsub! "${install_root=/}", "${install_root=#{File.dirname(__FILE__)}/tmp-dest}"
    end

    safesystem "make makefiles CCARGS='-DHAS_PGSQL -I/usr/local/include/pgsql -fPIC -DUSE_TLS -DUSE_SSL -DUSE_SASL_AUTH -DUSE_CYRUS_SASL -DHAS_LDAP -DLDAP_DEPRECATED=1 -DHAS_PCRE -I/usr/include/openssl -I/usr/include/sasl  -I/usr/include' AUXLIBS='-L/usr/local/lib -lpq -L/usr/lib64 -L/usr/lib64/openssl -lssl -lcrypto -L/usr/lib64/sasl2 -lsasl2 -lpcre -lz -lm -lldap -llber -Wl,-rpath,/usr/lib64/openssl -pie -Wl,-z,relro' OPT='-O' DEBUG='-g'"
    make
  end

  def install
    make :install, 'DESTDIR' => destdir, 'PREFIX' => prefix
    etc("/systemd/system").install workdir('postfix.service')
  end
end
