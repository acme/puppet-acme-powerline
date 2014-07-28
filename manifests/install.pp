# == Class: powerline
#
# This is the powerline module for installing Powerline.
#
# Powerline is a statusline plugin for vim, and provides statuslines and
# prompts for several other applications, including zsh, bash, tmux,
# IPython, Awesome and Qtile.
#
# === Parameters
#
# None.
#
# === Variables
#
# None.
#
# === Examples
#
# class { 'powerline': }
# powerline::install { 'acme': }
#
# === Authors
#
# Leon Brocard <acme@astray.com>
#
# === Copyright
#
# Copyright 2013 Leon Brocard.
#
define powerline::install() {

  file { 'powerline::~/.fonts/':
    ensure => 'directory',
    owner  => $name,
    group  => $name,
    mode   => '0750',
    path   => "/home/${name}/.fonts/",
  }

  file { 'powerline::~/.fonts.conf.d/':
    ensure => 'directory',
    owner  => $name,
    group  => $name,
    mode   => '0750',
    path   => "/home/${name}/.fonts.conf.d/",
  }

  exec { 'powerline::PowerlineSymbols.otf':
    creates => "/home/${name}/.fonts/PowerlineSymbols.otf",
    command => "/usr/bin/curl -L https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf -o /home/${name}/.fonts/PowerlineSymbols.otf",
    user    => $name,
    require => [Package['curl'], File['powerline::~/.fonts/']]
  }

  exec { 'powerline::10-powerline-symbols.conf':
    creates => "/home/${name}/.fonts.conf.d/10-powerline-symbols.conf",
    command => "/usr/bin/curl -L https://raw.github.com/Lokaltog/powerline/develop/font/10-powerline-symbols.conf -o /home/${name}/.fonts.conf.d/10-powerline-symbols.conf",
    user    => $name,
    require => [Package['curl'], File['powerline::~/.fonts.conf.d/']]
  }

  exec { 'powerline::fc-cache':
    command => "/usr/bin/fc-cache -vf /home/${name}/.fonts",
    user    => $name,
    returns => [1, 2, 3],
    unless  => '/usr/bin/fc-list | grep PowerlineSymbols 2>/dev/null',
    require => [Exec['powerline::PowerlineSymbols.otf'], Exec['powerline::10-powerline-symbols.conf']]
  }

}
