# @summary Configures an HTCondor Central Manager.
#
# This class configures a node to be an HTCondor Central Manager. It creates
# a specific configuration file for the manager, a pool password for
# authentication, and a condor token for secure communication.

class htcondor::central_manager {
  file { '/etc/condor/config.d/22_manager.config':
    ensure  => file,
    content => epp('htcondor/22_manager.config.epp'),
    mode    => '0644',
    notify  => Service['condor'],
  }

  exec { 'create_pool_password':
    command => 'umask 0077; echo -n "lhc6?h1c" | /usr/sbin/condor_store_cred add -c -i -',
    creates => '/etc/condor/passwords.d/POOL',
    user    => 'root',
    path    => ['/usr/bin', '/usr/sbin'],
    require => File['/etc/condor/passwords.d'],
  }

  exec { 'generate_condor_token':
    command => "umask 0077; condor_token_create -identity condor@condorcm.domain.com > /etc/condor/tokens.d/condor@condorcm.domain.com",
    creates => "/etc/condor/tokens.d/condor@condorcm.domain.com",
    user    => 'root',
    path    => ['/usr/bin', '/usr/sbin'],
    require => File['/etc/condor/tokens.d'],
    notify  => Service['condor'],
  }
}
