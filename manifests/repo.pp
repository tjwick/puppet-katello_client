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

    if $manage_repo and $agent_install {
      yumrepo { 'katello':
        descr       => 'Repo for katello tools and software',
        baseurl     => "http://fedorapeople.org/groups/katello/releases/yum/2.0/katello/RHEL/${::operatingsystemmajrelease}Server/${::architecture}/katello-repos-latest.rpm
        enabled     => 1,
        gpgcheck    => 0,
        require     => Yumrepo['sub-manager'],
    }
  }

    default: {
      fail("\"${module_name}\" provides no repository information for OSfamily \"${::osfamily}\"")
    }
  }
}

