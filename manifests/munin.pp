# manifests/munin.pp

class sendmail::munin {
    munin::plugin{ [ 'sendmail_mailqueue', 'sendmail_mailstats', 'sendmail_mailtraffic' ]: }
}

class sendmail::munin::disable inherits sendmail::munin {
    Munin::Plugin['sendmail_mailstats']{
         ensure => 'absent' 
    }
    Munin::Plugin['sendmail_mailtraffic']{
         ensure => 'absent' 
    }
    Munin::Plugin['sendmail_mailqueue']{
         ensure => 'absent' 
    }
}
