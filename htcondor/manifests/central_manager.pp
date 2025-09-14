# @summary Configures an HTCondor Central Manager.
#
# This class configures a node to be an HTCondor Central Manager. It creates
# a specific configuration file for the manager and a pool password for
# authentication.

class htcondor::central_manager (
  String $condor_host        = $htcondor::params::condor_host,
  String $condor_sched       = $htcondor::params::condor_sched,
  String $password_directory = $htcondor::params::password_directory,
  String $pool_password      = $htcondor::params::pool_password,
) {
  include htcondor::params

  file { '/etc/condor/config.d/22_manager.config':
    ensure  => file,
    content => epp('htcondor/22_manager.config.epp'),
    mode    => '0644',
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