# @summary Configures an HTCondor Worker node.
#
# It creates a specific configuration file for the
# worker, a sudoers file to grant necessary permissions, a pool password for
# authentication, and a condor token for secure communication.

class htcondor::worker {  
  file { '/etc/condor/config.d/20_workernode.config':
    ensure  => file,
    content => epp('htcondor/20_workernode.config.epp'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    notify  => Service['condor'],
  }
	
  file { '/etc/sudoers.d/condor':
    ensure  => file,
    mode    => '0440',
    source => "puppet:///modules/htcondor/sudoers.d/condor",
    owner   => 'root',
    group   => 'root'
  }

  exec { 'create_pool_password':
    command => 'umask 0077; echo -n "lhc6?h1c" | /usr/sbin/condor_store_cred add -c -i -',
    creates => '/etc/condor/passwords.d/POOL',
    user    => 'root',
    path    => ['/usr/bin', '/usr/sbin'],
    require => File['/etc/condor/passwords.d'],
  }

  exec { 'generate_condor_token':
    command => 'umask 0077; condor_token_create -identity condor@condorcm.domain.com > /etc/condor/tokens.d/condor@condorcm.domain.com',
    creates => '/etc/condor/tokens.d/condor@condorcm.domain.com',
    user    => 'root',
    path    => ['/usr/bin', '/usr/sbin'],
    require => File['/etc/condor/tokens.d'],
    notify  => Service['condor'],
  }
}