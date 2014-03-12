class InstagramController < ApplicationController
	require "rubygems"
	require "instagram"
	
	connected = false
		
	def index
		if not connected
			Instagram.configure do |config|
				config.client_id = "f21e26019fac4a278b9c72221cf5629a"
		  	config.client_secret = "9923cf8618984b62909f1d6abdc8df30"
			end
		end
		connected = true
	end
	
	def new
	end

	def search_user
		@user = Instagram.user_search(params[:user])
	end

	def connect
	end

	def oauth_connect
		redirect_to Instagram.authorize_url(:redirect_uri => "http://localhost:3000/oauth/callback")
	end

	def oauth_callback
		response = Instagram.get_access_token(params[:code], :redirect_uri => "http://localhost:3000/oauth/callback")
  	session[:access_token] = response.access_token
  	redirect_to "/profile"
	end
	
	def profile
		@client = Instagram.client(:access_token => session[:access_token])
		@user = @client.user
	end

end
