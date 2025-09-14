# @summary Installs and configures HTCondor.
#
# This class installs and configures a basic HTCondor node. It manages the
# installation of HTCondor, the configuration files, and the HTCondor service.
# This class is the main entry point for the module.

class htcondor (
  String $condor_host,
) {
  include htcondor::install
  include htcondor::service
  
  class { 'htcondor::config':
    condor_host => $condor_host,
  }
}
