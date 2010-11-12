#
# sendmail module
#
# Copyright 2008, Puzzle ITC GmbH
# Copyright 2010, Atizo AG
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi simon.josi+puppet(at)atizo.com
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

class sendmail {
  package{'sendmail':
    ensure => present,
  }
  service{'sendmail':
    enable => true,
    ensure => running,
    require => Package['sendmail'],
  }
  if $use_munin {
    include sendmail::munin
  }
  Mailalias { 
    target => '/etc/aliases',
    require => Package['sendmail'],
    notify => Exec['newaliases'],
  }
  exec{'newaliases':
    command => 'newaliases',
    refreshonly => true,
    require => Package['sendmail'],
  }
  exec{'sendmail_make':
    command => 'make -C /etc/mail',
    refreshonly => true,
    require => Package['sendmail'],
  }
}
