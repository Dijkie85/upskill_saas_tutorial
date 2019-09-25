class UsersController < ApplicationController
before_action :authenticate_user!

    # GET action for /users/:id
    def show
        @user = User.find( params[:id])
    end
    
    def index
    
    end
end