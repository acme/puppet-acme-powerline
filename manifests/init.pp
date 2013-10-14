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
#
# === Authors
#
# Leon Brocard <acme@astray.com>
#
# === Copyright
#
# Copyright 2013 Leon Brocard.
#
class powerline {

  if(!defined(Package['python'])) {
    package { 'python':
      ensure => present,
    }
  }

  if(!defined(Package['python-pip'])) {
    package { 'python-pip':
      ensure   => present,
      require  => Package['python']
    }
  }

  package { 'Powerline':
    provider => 'pip',
    source   => 'git+git://github.com/Lokaltog/powerline',
    require  => Package['python-pip']
  }

}
