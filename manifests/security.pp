# @summary Manages HTCondor security configuration.
#
# This class manages the main security configuration file for HTCondor.

class htcondor::security {
  file { '/etc/condor/config.d/10_security.config':
    ensure  => file,
    content => epp('htcondor/10_security.config'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }
}
