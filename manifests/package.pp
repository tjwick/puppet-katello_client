class katello_client::package {
  ####Package Management#####
  if $katello_client::agent_install == true {
    package { 'katello-agent':
      ensure  => $katello_client::version,
      require => Yumrepo['katello-pulp'],
    }
  }

  if $katello_client::subman_install {
    package { 'subscription-manager':
      ensure  => "$katello_client::subman_version",
      require => Yumrepo['sub-manager'],
    }
  }
  # fail("Katello-client version must be latest, or valid version number, you have provided \"${katello_client::version}\"")
}
