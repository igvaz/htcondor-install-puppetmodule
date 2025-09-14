# @summary Installs and configures HTCondor.
#
# This class installs and configures a basic HTCondor node. It manages the
# installation of HTCondor, the configuration files, and the HTCondor service.
# This class is the main entry point for the module.

class htcondor (
  String $condor_host        = $htcondor::params::condor_host,
  String $condor_sched       = $htcondor::params::condor_sched,
  String $password_directory = $htcondor::params::password_directory,
  Array[String] $local_dirs  = $htcondor::params::local_dirs,
) {
  include htcondor::params
  include htcondor::install
  include htcondor::service
  include htcondor::config
  include htcondor::security
}