class UsersController < ApplicationController
    # GET action for /users/:id
    def show
        @user = User.find( params[:id])
    
    
    end
end