# @summary Configures HTCondor Worker Nodes with Foreman Hostgroups
#
class htcondorcluster::workers {
  include htcondor::params
  include htcondor
  include htcondor::worker
}