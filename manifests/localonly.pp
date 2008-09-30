# manifests/localonly.pp
# manages sendmail installations
# which use sendmail only locally

class sendmail::localonly inherits sendmail {
    case $sendmail_mailroot {
        '': { fail("you need to define \$sendmail_mailroot to use this feature") }
    }

    sendmail::mailalias{'root':
        recipient => $sendmail_mailroot,
    }

    file{"/etc/mail/virtusertable":
        content => template("sendmail/virtusertable/virtusertable.${operatingsystem}"),
        notify => Exec[sendmail_make],
        require => Package[sendmail],
        mode => 0644, owner => root, group => 0;
    }
}
