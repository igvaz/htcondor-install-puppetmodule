# @summary Manages the HTCondor service.
#
# This class manages the `condor` service. It ensures that the service is
# running and enabled on boot.

class htcondor::service {
   service { 'condor':
    ensure => running,
    enable => true,
    require => Package['condor'],
 }
}