class htcondor::security {
  file { '/etc/condor/config.d/00-security':
    ensure  => file,
    content => epp('htcondor/security.epp'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }
}
