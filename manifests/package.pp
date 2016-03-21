class katello_client::package {
  ####Package Management#####

  if $katello_client::agent_install == true {
    package { 'katello-agent': ensure => $katello_client::version, }
  }

  if $katello_client::subman_install {
    package { 'subscription-manager': ensure => "$katello_client::subman_version", }
  }
}
