# == Class: katello_client
# This module leverages the jlaska/puppet-subscription_manager custom resource
# to configure and manage your katello content host subscriptions.
#
# == Parameters
# [*version*]
#   String. Version of katello agent to install
#   Default: latest
#   Valid values: latest, present, [\d\.\-]+
#
# [*subman_version*]
#   String. Version of subscription-manager to install
#   Default: latest
#   Valid values: latest, present, [\d\.\-]+
#
# [*katello_host*]
#   String. FQDN of the katello host to subscribe to
#   Default: undef
#   Valid values: Shortname, FQDN
#
# [*content_org*]
#   String. Name of the organization to subscribe to within katello.
#   Default: undef
#   Valid values: The "label" of selected katello organization
#
# [*environment*]
#   String. Name of the Lifecycle Environment to subscribe to.
#   Default: undef
#   Valid values: Name of individual environment
#
# [*activationkey*]
#   Array. CSV of the activation keys to leverage for content host subscription.
#   Default: []
#   Valid values: Activation key names with assigned content views.
#
# [*agent_install*]
#   Boolean. Bool of whether not to install the katello-agent package.
#   Default: true
#   Valid values: true, false
#
# [*subman_install*]
#   Boolean. Bool of whether not to install the subscription-manager package.
#   Default: true
#   Valid values: true, false
#
# [*username*]
#   String. Username to use with content subscription in the case of not using activation keys.
#   Default: undef
#   Valid values: valid_username
#
# [*password*]
#   String. Password to use with content subscription in the case of not using activation keys.
#   Default: undef
#   Valid values: valid_password
#
# [*manage_repo*]
#   Boolean. Bool whether or not to include and manage the katello-pulp repo.
#   Default: true
#   Valid values: true, false
#
# [*$cacert*]
#   The (optional) SSL CA certificate used to validate the server certificate.
#   Default: '/etc/rhsm/ca/candlepin-local.pem'
#
# [*clientcert*]
#   The (optional) SSL client certificate.  PEM encoded and contains both key and certificate.
#   Default: '/etc/pki/consumer/bundle.pem'
#
# [*sub_manager_repo_name*]
#   The name of the sub-manager yum repo, in case wanting to customize names.
#   Default: 'sub-manager'
#
class katello_client ($version               = latest,
                      $subman_version        = latest,
                      $katello_host          = undef,
                      $content_org           = undef,
                      $environment           = undef,
                      $activationkey         = [],
                      $agent_install         = true,
                      $subman_install        = true,
                      $username              = undef,
                      $password              = undef,
                      $manage_repo           = true,
                      $ensure                = present,
                      $cacert                = '/etc/rhsm/ca/candlepin-local.pem',
                      $clientcert            = '/etc/pki/consumer/bundle.pem',
                      $sub_manager_repo_name = 'sub-manager',
                      ){
  validate_bool($agent_install,)
  validate_bool($subman_install,)
  validate_bool($manage_repo,)
  validate_string($katello_host,)
  validate_string($content_org)
  validate_string($environment)
  validate_re($version, ['^latest$', '^[\d\.\-]+$'],"Invalid package version for katello-agent: ${version}")
  validate_re($ensure, ['^present$', '^absent$'],"Invalid subscription state: ${ensure}. Please provide absent or present")
  validate_re($subman_version, ['^latest$', '^[\d\.\-]+$'], "Invalid package version for subscription-manager: ${version}")
  if $activationkey{validate_array($activationkey,)}
  if $username{validate_string($username,)}
  if $password{validate_string($password,)}  

  anchor {'katello_client::begin':} ->
  class{'katello_client::repo':} ->
  class{'katello_client::package':} ->
  class{'katello_client::config':} ~>
  class{'katello_client::service':} ->
  class{'katello_client::subscription':} ->
  anchor {'katello_client::end':}
}
