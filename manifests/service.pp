class htcondor::service {
   service { 'condor':
    ensure => running,
    enable => true,
    require => Package['condor'],
 }
}