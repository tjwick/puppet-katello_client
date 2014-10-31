require 'puppet/parameter/boolean'
require 'puppet/type'

Puppet::Type.newtype(:katello_register) do
  @doc = ""

  ensurable do

    newvalue(:present) do
      provider.create
    end

    newvalue(:absent) do
      provider.destroy
    end

    def insync?(is)

      @should.each do |should|
        case should
          when :present
            return true if is == :present
          when :absent
            return true if is == :absent
        end
      end
      return false
    end
    defaultto :present
  end

  newparam(:katello_host, :namevar => true) do
    desc "The hostname of the katello host."
  end

  newparam(:katello_cert) do
    desc "CA certificate for the repository and the issued client certs in the case of custom certificates and no bootstrap"
  end

  newparam(:username) do
    desc "The username to use when registering the system"
  end

  newparam(:password) do
    desc "The password to use when registering the system"
  end

  newparam(:activationkeys) do
    desc "The activation key to use when registering the system (cannot be used with username and password)"
  end

  newparam(:environment) do
    desc "The Lifecycle Environment to Subscribe to."
  end

  newparam(:org) do
    desc "The organization the system should be assigned to."

    validate do |value|
      if value.empty?
        raise ArgumentError,
              "org paramater may not be empty"
      end
    end
  end

end