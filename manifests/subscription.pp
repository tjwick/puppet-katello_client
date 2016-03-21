class katello_client::subscription {
  ## Bootstrap to the katello host for providing appropriate SSL keys Case statement for adding multiple os support later##

  case $::osfamily {
    'RedHat', 'Linux' : {
      exec { 'bootstrap':
        command => "/bin/rpm -Uvh http://${katello_client::katello_host}/pub/katello-ca-consumer-latest.noarch.rpm",
        creates => '/etc/rhsm/ca/katello-server-ca.pem',
        require => Yumrepo['sub-manager'],
        before  => Rhsm_register['katello'],
      }

      if $katello_client::activationkey {
        katello_register { 'katello':
          ensure          => $katello_client::ensure,
          katello_host    => $katello_client::katello_host,
          org             => $katello_client::content_org,
          environment     => $katello_client::environment,
          activationkeys  => [$katello_client::activationkey],
        }
      } else {
        katello_register { 'katello':
          ensure          => $katello_client::ensure,
          katello_host    => $katello_client::katello_host,
          org             => $katello_client::content_org,
          environment     => $katello_client::environment,
          username        => $katello_client::username,
          password        => $katello_client::password,
        }
      }
    }
  }
}

