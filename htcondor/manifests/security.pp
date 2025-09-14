# @summary Manages HTCondor security configuration.
#
# This class manages the main security configuration file for HTCondor.

class htcondor::security {
  include htcondor::params
  
  file { '/etc/condor/config.d/10_security.config':
    ensure  => file,
    content => epp('htcondor/10_security.config.epp', {
      'condor_host'        => $htcondor::params::condor_host,
      'condor_sched'       => $htcondor::params::condor_sched,
      'domain'             => $htcondor::params::domain,
      'password_directory' => $htcondor::params::password_directory,
    }),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }
}