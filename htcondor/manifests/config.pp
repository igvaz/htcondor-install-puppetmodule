# @summary Manages HTCondor configuration files.
#
# This class manages the main HTCondor configuration file `/etc/condor/condor_config`,
# and several related directories. It creates the main configuration directories and
# also local directories for HTCondor to use.

class htcondor::config (
  String $condor_host        = $htcondor::params::condor_host,
  String $condor_sched       = $htcondor::params::condor_sched,
  String $password_directory = $htcondor::params::password_directory,
  Array[String] $local_dirs  = $htcondor::params::local_dirs,
) {
  include htcondor::params
  include htcondor::security

  file { '/etc/condor':
    ensure  => directory,
    recurse => true,
    purge   => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }->

  file { '/etc/condor/config.d':
    ensure  => directory,
    recurse => true,
    purge   => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }->

  file { '/etc/condor/condor_config':
    ensure  => file,
    content => epp('htcondor/condor_config.epp'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    notify  => Service['condor'],
  }

  file { $password_directory:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
  }

  file { $local_dirs:
    ensure => directory,
    owner  => 'condor',
    group  => 'condor',
    mode   => '0775',
  }
}