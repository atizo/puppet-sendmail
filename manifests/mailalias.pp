define sendmail::mailalias(
  $recipient,
  $ensure = 'present',
  $target = 'absent'
) {
  include sendmail
  mailalias{$name:
    ensure => $ensure,
    recipient => $recipient,
    target => '/etc/aliases',
    notify => Exec['newaliases'],
  }
}
