class htcondor::config (
  String $condor_host = 'condorcm.domain.com',
  String $token_directory = '/etc/condor/tokens.d',
  String $password_directory = '/etc/condor/passwords.d',
) {
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
    content => epp('htcondor/condor_config.epp', {
      'condor_host'        => $condor_host,
      'token_directory'    => $token_directory,
      'password_directory' => $password_directory,
    }),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    notify  => Service['condor'],
  }

  file { $token_directory:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
  }

  file { $password_directory:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
  }
  
  $local_dirs = ['/localdisk1', '/localdisk1/condor', '/localdisk1/condor/run',
                '/localdisk1/condor/lock', '/localdisk1/condor/spool', 
                '/localdisk1/condor/execute']
  
  file { $local_dirs:
    ensure => directory,
    owner  => 'condor',
    group  => 'condor',
    mode   => '0775',
  }
}