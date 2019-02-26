class UsersController < ApplicationController
	def index
  		@name = "I am the Index action!"
	end
	def new
  		@name = "I am the new action!"
  		render :index
	end
	def edit
  		@name = "I am the edit action!"
  		render :index
	end
	def show
  		@name = "I am the show action!"
  		render :index
	end
	def destroy
  		@name = "I am the destroy action!"
	end
	def create
  		@name = "I am the create action!"
	end
	
	def update
  		@name = "I am the update action!"
	end
end
