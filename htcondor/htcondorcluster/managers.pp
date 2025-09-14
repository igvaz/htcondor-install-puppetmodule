# @summary Configures HTCondor Manager Nodes with Foreman Hostgroups
#
class htcondorcluster::managers {
  include htcondor
  include htcondor::central_manager
}