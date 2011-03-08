class sendmail::disable inherits sendmail {
  Service['sendmail']{
    enable => false,
    ensure => stopped,
  }
  if $use_munin {
    include sendmail::munin::disable
  }
}
