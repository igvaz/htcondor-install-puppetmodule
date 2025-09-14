# @summary Configures HTCondor Manager Nodes with Foreman Hostgroups
#
class htcondorcluster::managers {
  include htcondor::install
  include htcondor::service
  include htcondor::config
  include htcondor::central_manager
}