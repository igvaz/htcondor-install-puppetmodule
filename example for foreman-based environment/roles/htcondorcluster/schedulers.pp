# @summary Configures HTCondor Scheduler Nodes with Foreman Hostgroups
#
class htcondorcluster::schedulers {
  include htcondor::config
  include htcondor::scheduler
}