# PUPPET-KATELLO_CLIENT

This module provides configuration and management of registration and consumption of katello content subscriptions.
It borrows heavily from jlaska's custom rhsm provider type.

## License

Read Licence file for more information.

## Requirements
* puppet-boolean [on GitHub](https://github.com/adrienthebo/puppet-boolean)

## Authors
* Ian Henry (Craft___)


### katello_client Parameters
- **version**: Version of katello agent to install.
- **subman_version**: Version of subscription-manager to install.
- **katello_host**: FQDN of the katello host to subscribe to.
- **content_org**: Name of the organization to subscribe to within katello.
- **environment**: Name of the Lifecycle Environment to subscribe to.
- **activationkey**: CSV of the activation keys to leverage for content host subscription.
- **agent_install**: Bool of whether to install the katello-agent package.
- **username**: Username to use with conten subscription in the case of not leveraging activation keys.
- **password**: Password to use with content subscription in the case of not using activation keys.
- **manage_repo**: Bool of whether to include management of the katello-pulp repo
- **ensure**: Absent, present, to allow for subscribe/unsubscribe

### katello_client Examples

Install katello-agent, subscription-manager and subscribe with a configured
activation key.

<pre>
class { 'katello_client':
  katello_host  => 'katello.foobar.org', 
  content_org   => 'katello_org',
  activationkey => 'production',
}
</pre>

Install katello-agent, subscription-manager and subscribe using a username and password:

<pre>
class { 'katello_client':
  katello_host  => 'katello.foobar.org',
  content_org   => 'katello_org',
  environment   => 'test_environment',
  username      => 'userfoo',
  password      => 'passbar'
}

</pre>

## Installing

In your puppet modules directory:

    git clone https://github.com/Craft---/puppet-katello_client.git

Ensure the module is present in your puppetmaster's own environment.

## Issues

Please file any issues or suggestions on [on GitHub](https://github.com/Craft---/puppet-katello_client/issues)

