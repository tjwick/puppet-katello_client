class katello_client::repo {

### Repo config, using case to allow for future support of SUSE or Debian ###

  case $::osfamily{
    'RedHat', 'Linux':{
      yumrepo { 'sub-manager':
        descr      => 'An open source entitlement management system',
        baseurl    => "http://repos.fedorapeople.org/repos/candlepin/subscription-manager/epel-${::operatingsystemmajrelease}/${::architecture}/",
        enabled    => 1,
        gpgcheck   => 0,
    }
    if $katello_client::manage_repo and $katello_client::agent_install {
      yumrepo { 'katello-pulp':
        descr       => 'Pulp Community Releases',
        baseurl     => "http://fedorapeople.org/groups/katello/releases/yum/2.0/katello/RHEL/${::operatingsystemmajrelease}Server/${::architecture}/",
        enabled     => 1,
        gpgkey      => 'http://www.katello.org/gpg/RPM-GPG-KEY-katello-2012.gpg',
        gpgcheck    => 1,
        require     => Yumrepo['sub-manager'],
      }
    }
  }
    default: {
      fail("katello-client provides no repository information for OSfamily ${::osfamily}")
    }
  }

}

