# rsetup

## About

This is rsetup for FreeBSD 10.1-RELEASE. It's a set of shell scripts to easily
install things I often want on a new install.

## Prerequisites

1. Bash (`pkg install bash`)
2. Modern SSL certificates (`pkg install ca_root_nss && ln -s /usr/local/etc/ssl/cert.pem /etc/ssl/cert.pem`)

## Packages

+ mysql: MariaDB 5.5 (client + server)
+ postgresql: PostgreSQL 9.3 (client + server), PostGIS 2.1 (slow, uses ports)
+ python2: Python 2.7 + pip
+ python3: Python 3.4 + pip
+ ruby: (broken; instructs user on installing)
+ rvm: latest RVM

## Installation

Clone this repo into `/usr/rsetup`. Optionally, symlink `/usr/rsetup/rsetup`
somewhere in your path (e.g., `/usr/local/bin/rsetup`) for easier use.

At present, it **must** be installed to `/usr/rsetup` as some paths are
hard-coded.

## Usage

Simply run `rsetup` with an argument for the package you want to install. For
example, to install PostgreSQL and PostGIS, run `/usr/rsetup/rsetup postgresql`.

## License

Licensed under [the MIT license](https://github.com/rnelson/rsetup/blob/master/LICENSE).