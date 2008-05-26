# manifests/localonly.pp
# manages sendmail installations
# which use sendmail only localy

class sendmail::localonly inherits sendmail {
    file{"/etc/aliases":
        source => [ "puppet://$server/files/sendmail/aliases/aliases.${operatingsystem}",
                    "puppet://$server/files/sendmail/aliases/aliases",
                    "puppet://$server/sendmail/aliases/aliases.${operatingsystem}",
                    "puppet://$server/sendmail/aliases/aliases" ],
        require => Package[sendmail],
        notify => Exec[newaliases],
        mode => 0644, owner => root, group => 0;
    }

    $real_sendmail_mailroot = $sendmail_mailroot ? {
        '' => 'monitor@ww2.ch',
        default => $sendmail_mailroot
    }

    file{"/etc/mail/virtusertable":
        content => template("sendmail/virtusertable/virtusertable.${operatingsystem}"),
        notify => Exec[sendmail_make],
        require => Package[sendmail],
        mode => 0644, owner => root, group => 0;
    }

    if $use_sendmail {
        include sendmail::shorewall::localonly
    }
}

class sendmail::shorewall::localonly {
    case $shorewall_mailserver {
        '': { $mailserver_dest = 'all' }
        default: { 
            shorewall::param{"MAILSERVER": value => "$shorewall_mailserver" }
            $mailserver_dest = 'net:$MAILSERVER'
        }
    }
    shorewall::rule { 'me-net-mailserver_tcp':
        source          => '$FW',
        destination     => "$mailserver_dest",
        proto           => 'tcp',
        destinationport => 'smtp,smtps',
        order           => 320,
        action          => 'ACCEPT';
    }
}
