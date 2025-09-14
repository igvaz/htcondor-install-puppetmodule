# @summary Configures an HTCondor Scheduler.
#
# This class configures a node to be an HTCondor Scheduler. It creates
# a specific configuration file for the scheduler and a pool password for
# authentication.

class htcondor::scheduler (
  String $condor_host        = $htcondor::params::condor_host,
  String $condor_sched       = $htcondor::params::condor_sched,
  String $password_directory = $htcondor::params::password_directory,
  String $pool_password      = $htcondor::params::pool_password,
) {
  include htcondor::params

  file { '/etc/condor/config.d/21_schedd.config':
    ensure  => file,
    content => epp('htcondor/21_schedd.config.epp'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    notify  => Service['condor'],
  }

  exec { 'create_pool_password':
    command => "umask 0077; echo -n '${pool_password}' | /usr/sbin/condor_store_cred add -c -i -",
    creates => "${password_directory}/POOL",
    user    => 'root',
    path    => ['/usr/bin', '/usr/sbin'],
    require => File[$password_directory],
    notify  => Service['condor'],
  }
}