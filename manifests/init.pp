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
