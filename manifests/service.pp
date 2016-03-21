# Katello_client Service Packages
class katello_client::service {
  service { 'goferd':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
