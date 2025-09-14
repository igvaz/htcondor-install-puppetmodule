# @summary Centralized default parameters for the HTCondor Puppet module.
#
# This class provides default values for all configurable parameters used
# throughout the htcondor module. Other classes should include this class
# and use these variables as defaults.

class htcondor::params {
  $condor_host        = 'central_manager_hostname'
  $condor_sched       = 'scheduler_hostname'
  $password_directory = '/etc/condor/passwords.d'
  $local_dirs         = [
    '/localdisk1',
    '/localdisk1/condor',
    '/localdisk1/condor/run',
    '/localdisk1/condor/lock',
    '/localdisk1/condor/spool',
    '/localdisk1/condor/execute'
  ]
  $pool_password      = 'your_pool_password'
  $domain             = 'example.domain.com'
}