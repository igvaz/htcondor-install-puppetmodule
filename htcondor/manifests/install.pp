# @summary Manages the installation of HTCondor.
#
# This class manages the HTCondor YUM repository and the installation of the
# `condor` package. It ensures that the HTCondor repository is configured
# and that the HTCondor package is installed.
# You can modify this content accordingly to your environment

class htcondor::install {
  yumrepo { 'htcondor-stable':
    ensure   => present,
    baseurl  => 'https://research.cs.wisc.edu/htcondor/yum/stable/rhel9/x86_64',
    descr    => 'HTCondor Stable Repository',
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => 'https://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor',
  }

  package { 'condor':
    ensure  => installed,
    require => Yumrepo['htcondor-stable'],
  }
}