# Pulp Katello_agent Configuration
class katello_client::config {
  file { '/etc/gofer/plugins/katelloplugin.conf':
    ensure  => 'file',
    content => template('katello_client/katelloplugin.conf'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
