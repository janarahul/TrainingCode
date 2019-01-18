#controller inherits from ApplicationController, and ApplicationController inherits from ActionController::Base,
class ClientsController < ApplicationController
	def new
		@client = Client.new
	end
end

#accessing data sent by user:  URL data or POST data
#available through params hash

class Clientcontroller < ActionController::Base
	def new
		if params[:status] == "activated"
			@client = Client.activateed
		else
			@client = Client.deactivated
		end
	end

	def create
		@client = Client.create(params[:client])
		if @client.save
			redirect_to @client
		else
			render :acion => "new"
		end
	end
end

#Verifications make sure certain criteria are met in order for a controller or action to run
#default action is 404 bad requet 
#Example- in Controller
verify  :params => [:username, :password],
				:render => {:action => new}
				:add_flash => {
					:error => "Error message"
				},
				:only => :create


class AdminController < ApplicationController
  USERNAME, PASSWORD = "humbaba", "5baa61e4"

  before_filter :authenticate

private
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == USERNAME &&
      Digest::SHA1.hexdigest(password) == PASSWORD
    end
  end
end

#Streaming and File downloads
#Sometimes we need to send file, all contollers have send_data send_file methods

send_file("path_to_file", :filename => "file_name", :type => "application/pdf")

#RESTful 

class ClientsController < ApplicationController
  # The user can request to receive this resource as HTML or PDF.
  def show
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf { render :pdf => generate_pdf(@client) }
    end
  end
end

	private

  def generate_pdf(client)
    Prawn::Document.new do
      text client.name, :align => :center
      text "Address: #{client.address}"
      text "Email: #{client.email}"
    end.render
  end
end
