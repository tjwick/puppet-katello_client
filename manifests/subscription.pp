class katello_client::subscription {

## Bootstrap to the katello host for providing appropriate SSL keys Case statement for adding multiple os support later##

  case $::osfamily {

    'RedHat','Linux'{
      package {'bootstrap':
        ensure          => present,
        source          => "http://${katello_client::katello_host}/pub/katello-ca-consumer-latest.noarch.rpm",
        require         => Yumrepo['sub-manager'],
      }
  }
  if $katello_client::activationkey {

    rhsm_register { 'katello':
      ensure          => present,
      server_hostname => $katello_client::katello_host,
      org             => $katello_client::content_org,
      environment     => $katello_client::environment,
      activationkeys  => [$katello_client::activationkey],
      require         => Package['bootstrap'],
    }   
  } else {
    rhsm_register {'katello':
      ensure          => present,
      server_hostname => $katello_client::katello_host,
      org             => $katello_client::content_org,
      environment     => $katello_client::environment,
      username        => $katello_client::username,
      password        => $katello_client::password,
      require         => Package['bootstrap'],
    }
  } 
}
