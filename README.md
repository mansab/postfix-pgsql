# class Postfix < FPM::Cookery::Recipe

This is an FPM recipe for building Postfix with PGSQL support.

Author: Mansab Uppal

Official site: http://mansab.upp.al

Official git repository: https://github.com/mansab/postfix-pgsql

##Overview

This FPM recipe builds Postfix RPM package by fetching the required version of Source Tarball.

The recipe compiles Postfix supporting LDAP, SMTP AUTH (SASL),TLS with additional support for pgsql.

Since, Postfix comes installed with most of the distributions, I have toggeled the Package version by a prefix '2:' (2 because of Postfix version 2.xx.x).

This will ensure that this package is installed in case of other Packages are present on the repository since this one being the latest.

##Recipe description

The recipe will:

* Fetch the required version of Postfix from http://de.postfix.org/ftpmirror/official/.
* Configure and compile Postfix with pgsql support, LDAP, SMTP AUTH (SASL).
* Copy the executables and other required files created during the 'make' to required directories.
* The above steps will ask for directory paths, just use the default path in the promt.
* Create Upstart script for Postfix daemon.
* Drop the pre, post install/un-install scripts.
* Finally, packages everything into an RPM. 

## Quick Start

### Requirements

The build server must have following packages installed:

### CentOS:
* libdb
* libdb-devel
* gcc
* openssl
* openssl-devel
* pcre
* pcre-devel
* openldap-devel
* cyrus-sasl
* cyrus-sasl-devel
* openldap
* postgresql-devel

### Required GEM

* fpm-cookery

NOTE: The recipe has been tested (and can only create) with creating packages for 'el7', 'x86_64' architecture packages.

### Building a package
You need to specify the version of Postfix package to be fetched and built.

```fpm
BUILD_VERSION=2.11.1 fpm-cook
```

### Building a new release

```fpm
BUILD_VERSION=2.11.1 BUILD_REV=1.el7 fpm-cook
```

### Related

* FPM Cookery: https://github.com/bernd/fpm-cookery
* Tarsnap: http://tarsnap.com
