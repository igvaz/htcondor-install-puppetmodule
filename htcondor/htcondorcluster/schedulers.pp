# @summary Configures HTCondor Scheduler Nodes with Foreman Hostgroups
#
class htcondorcluster::schedulers {
  include htcondor
  include htcondor::scheduler
}