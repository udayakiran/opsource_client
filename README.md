## ruby-opsource
=============


Ruby client for Opsource cloud's REST API. Opsource cloud is formally Dimension Data now.

0. API spec - https://github.com/udayakiran/opsource_client/raw/master/doc/Cloud-REST-API-v09-032113.pdf

0. API details - http://cloud.dimensiondata.com/saas-solutions/services/public-cloud/api


NOTE: This is the base client framework and a few sample APIs. More APIs can be added as you need by referring the document attached above.


## Usage

To use it as a gem -

     gem install opsource_client

OR

     gem 'opsource_client', git: 'https://github.com/udayakiran/opsource_client.git'

To use it as a rails plugin (For older versions of rails) -

     git clone https://github.com/udayakiran/opsource_client.git

     copy opsource_client to vendors/plugins

## Configuration -

This is a one time configuration where you specify your opsource account's organization id,
username and password of the admin account using which API calls need to be made.

    client = OpsourceClient::Client.new
    client.organization_id = organization_id
    client.admin_username =  admin_username
    client.admin_password =  admin_password
  

## Sample API call -

To create a NAT rule

    opc = OpsourceClient::Client.new

    # ...

    opc.create_natrule({:net_id => network_id, :sourceIp => private_ip, :name => private_ip})


