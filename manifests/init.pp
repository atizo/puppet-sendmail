#######################################
# sendmail module
# Puzzle ITC - haerry+puppet(at)puzzle.ch
# GPLv3
#
# manages sendmail stuff
#######################################


# modules_dir { "sendmail": }
class sendmail {
    include sendmail::base

    exec{sendmail_make:
        command => 'cd /etc/mail/ && make',
        refreshonly => true,
        require => Package[sendmail],
    }
    exec{newaliases:
        command => '/usr/bin/newaliases',
        refreshonly => true,
        require => Package[sendmail],
    }
}

class sendmail::base {
    package{sendmail:
        ensure => present,
    }

    service{sendmail:
        enable => true,
        ensure => running,
        require => Package[sendmail],
    }
}
