Puppet::Type.type(:katello_register).provide(:subscription_manager) do
  @doc = <<-EOS
    This provider registers a machine with Katello Lifecycle Environments.
    If a machine is already registered it does nothing.
  EOS

  confine :osfamily => :redhat

  commands :subscription_manager => "subscription-manager"

  def config_parameters
    params = []
    params << "config"
    params << "--server.hostname" << @resource[:katello_host] if ! @resource[:katello_host].nil?
    params << "--rhsm.repo_ca_cert" << @resource[:katello_cert] if ! @resource[:katello_cert].nil?

    return params
  end

  def registration_parameters
    params = []
    if @resource[:username].nil? and @resource[:activationkeys].nil?
      self.fail("Either an activation key or username/password is required to register")
    end

    if @resource[:org].nil?
      self.fail("The 'org' paramater is required to register the system")
    end

    params << "register"
    params << "--username" << @resource[:username] if ! @resource[:username].nil?
    params << "--password" << @resource[:password] if ! @resource[:password].nil?
    params << "--activationkey" <<  @resource[:activationkeys] if ! @resource[:activationkeys].nil?
    params << "--environment" << @resource[:environment] if ! @resource[:environment].nil?
    params << "--org" << @resource[:org]

    return params
  end

  def config
    Puppet.debug("This server will be configured for registration")
    cmd = config_parameters
    subscription_manager(*cmd)
  end

  def register
    Puppet.debug("This server will be registered")
    cmd = registration_parameters
    subscription_manager(*cmd)
  end

  def unregister
    Puppet.debug("This server will be unregistered")
    cmd = []
    cmd << "unregister"
    subscription_manager(*cmd)
  end

  def create
    config
    register
    # subscribe
  end

  def destroy
    unregister
  end

  def exists?
    Puppet.debug("Verifying that the client is not already registered")
    if File.exists?("/etc/pki/consumer/cert.pem") or File.exists?("/etc/pki/consumer/key.pem")
      return true
    else
      return false
    end
  end
  end
