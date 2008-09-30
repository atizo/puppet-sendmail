# manifests/sendmail/defines.pp

define sendmail::mailalias(
    $ensure = 'present',
    $recipient,
    $target = '/etc/aliases'
){
    include sendmail::newaliases

    mailalias{"$name":
        ensure => $ensure,
        recipient => $recipient,
        target = $taraget,
        notify => Exec['refresh_aliases'],
    }
}
