class sendmail::munin::disable inherits sendmail::munin {
  Munin::Plugin['sendmail_mailstats']{
    ensure => 'absent',
  }
  Munin::Plugin['sendmail_mailtraffic']{
    ensure => 'absent',
  }
  Munin::Plugin['sendmail_mailqueue']{
    ensure => 'absent',
  }
}
