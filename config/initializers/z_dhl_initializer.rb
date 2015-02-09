require 'ucppool'
require 'prop_loader'

begin
  # if we have not initialized the $application_properties then load in the property file and read in the props
  #  storing it in the hash
  if $application_properties.nil?
    $application_properties = PropLoader.load_properties('./dhl.properties')
    # $logger.debug("Application properties loaded successfully.")
    puts("Application properties loaded successfully.")
  end
rescue
  puts "Failed to load ./dhl.properties "<< $!.to_s
  puts "Terminating Application server!"
  Process.exit
end

begin
  oracle_connect = $application_properties['oracle_env']
  oracle_id = $application_properties['oracle_user']
  oracle_password = $application_properties['oracle_passwd']
  max_ucp_pool_size = $application_properties["max_ucp_pool_size"].to_i
  $pool = MyOracleUcpPool.new(oracle_id, oracle_password, oracle_connect, 0, max_ucp_pool_size, 2)
rescue
  puts "Could not create an oracle connection pool! "<< $!.to_s
  Process.exit
end