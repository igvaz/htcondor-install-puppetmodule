class htcondor (
  String $condor_host,
) {
  include htcondor::install
  include htcondor::service
  
  class { 'htcondor::config':
    condor_host => $condor_host,
  }
}
