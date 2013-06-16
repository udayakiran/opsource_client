ruby-opsource
=============

(WORK IN PROGRESS ...)

Ruby client for Opsource cloud's REST API - http://www.opsource.net/Services/Cloud-Hosting/Open-API

To use it as a gem - (Coming soon)

To use it as a rails plugin -

1. git clone https://github.com/udayakiran/opsource_client.git

2. copy opsource_client to vendors/plugins

Configuration -

This is a one time configuration where you specify your opsource account's organization id,
username and password of the admin account using which API calls need to be made.

OpsourceClient::Client.configure do

  organization_id organization_id
  
  admin_username  admin_username
  
  admin_password  admin_password
  
end

Sample API call -

To create a NAT rule

opc = OpsourceClient::Client.instance

opc.create_natrule({:net_id => network_id, :sourceIp => private_ip, :name => private_ip})


