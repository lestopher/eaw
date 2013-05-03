class DashboardController < ApplicationController

  def index 
    endpoint = 'https://evidevjs1.evisions.com/'
    client_username = "ca_user"
    client_password = "ca_user"
    hash  = '5a2fb8e0701ae1c44c6966698c894278'
    datablock  = 297

    client = Eviapi.client

    client.client_username = client_username
    client.client_password = client_password
    client.endpoint           = endpoint

    response = client.session_setup

    @flash = 'Could not setup session' and exit unless response.valid
    @flash = 'Could not find session id' and exit unless response.data.SessionId

    session = response.data.SessionId

    response = client.session_authenticate

    @flash = 'Could not authenticate user' and exit unless response.valid

    response = client.session_securitytoken_create

    @flash = 'Could not get token' and exit unless response.valid

    token = response.data.Token

    @url = "#{endpoint}Argos/AWV/#!DataBlock=#{datablock}&Username=#{client_username}&Token=#{token}&Hash=#{hash}"     
  end

end
