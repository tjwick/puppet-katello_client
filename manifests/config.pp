class katello_client::config {

    exec {'bootstrap':
      command         => "rpm -Uvh http://${katello_client::katello_host/pub/katello-ca-consumer-latest.noarch.rpm}",
      creates         => "/etc/rhsm/ca/katello-server-ca.pem",
      require         => Yumrepo['sub-manager'],
    }

  if $katello_client::activationkey {

    rhsm_register { 'katello':
      ensure          => present,
      server_hostname => $katello_client::katello_host,
      org             => $katello_client::content_org,
      environment     => $katello_client::environment,
      activationkeys  => $katello_client::activationkey,
    }   
  } else {
    rhsm_register {'katello':
      ensure          => present,
      server_hostname => $katello_client::katello_host,
      org             => $katello_client::content_org,
      environment     => $katello_client::environment,
      username        => $katello_client::username,
      password        => $katello_client::password,
    }
  } 
}
