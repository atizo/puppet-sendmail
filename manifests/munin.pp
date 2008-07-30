# manifests/munin.pp

class munin::sendmail {
    munin::plugin{'sendmail': }
}

class munin::sendmail::disable inherits munin::sendmail {
    Munin::Plugin['sendmail']{
         ensure => 'absent' 
    }
}
