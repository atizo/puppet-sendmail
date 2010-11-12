class sendmail::munin {
  munin::plugin{ [ 'sendmail_mailqueue', 'sendmail_mailstats', 'sendmail_mailtraffic' ]:
    config => 'user root',
  }
}
