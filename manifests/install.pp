# Modify this content accordingly to your environment

class htcondor::install {
  yumrepo { 'htcondor-stable':
  baseurl => 'https://research.cs.wisc.edu/htcondor/yum/stable/rhel9/x86_64',
  descr => 'HTCondor Stable Repository',
  enabled => 1,
  gpgcheck => 1,
  gpgkey => 'https://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor',
}

  package { 'condor':
    ensure => installed,
    require => Yumrepo['htcondor-stable'],
  }
}