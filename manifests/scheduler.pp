# @summary Configures an HTCondor Scheduler.
#
# This class configures a node to be an HTCondor Scheduler. It creates
# a specific configuration file for the scheduler, a pool password for
# authentication, and a condor token for secure communication.
#
# @param condor_host
#   The hostname of the HTCondor central manager.
# @param token_directory
#   Directory for HTCondor tokens.
# @param password_directory
#   Directory for HTCondor passwords.
# @param pool_password
#   Password for pool authentication.
# @param manager_identity
#   Identity for the condor token.

class htcondor::scheduler (
  String $condor_host        = htcondor::params::$condor_host,
  String $token_directory    = htcondor::params::$token_directory,
  String $password_directory = htcondor::params::$password_directory,
  String $pool_password      = htcondor::params::$pool_password,
  String $manager_identity   = htcondor::params::$manager_identity,
) {
  include htcondor::params

  file { '/etc/condor/config.d/21_schedd.config':
    ensure  => file,
    content => epp('htcondor/21_schedd.config.epp', {
      'condor_host' => $condor_host,
    }),
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
  }

  exec { 'generate_condor_token':
    command => "umask 0077; condor_token_create -identity ${manager_identity} > ${token_directory}/${manager_identity}",
    creates => "${token_directory}/${manager_identity}",
    user    => 'root',
    path    => ['/usr/bin', '/usr/sbin'],
    require => File[$token_directory],
    notify  => Service['condor'],
  }
}