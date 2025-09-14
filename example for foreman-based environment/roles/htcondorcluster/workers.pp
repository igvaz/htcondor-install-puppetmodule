# @summary Configures HTCondor Worker Nodes with Foreman Hostgroups
#
class htcondorcluster::workers {
  include htcondor::install
  include htcondor::service
  include htcondor::config
  include htcondor::worker
}