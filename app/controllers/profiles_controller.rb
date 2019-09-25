class ProfilesController < ApplicationController
    def new
        # GET -> Render blank profile form
        @profile = Profile.new
    end
    
    def create
        # POST -> Creates or updates profile to /users/:user_id/profile
        # Ensure the user is building the profile
        @user = User.find(params[:user_id])
        @profile = @user.build_profile( profile_params )
        if @profile.save
            flash[:success] = "Perfil actualizado"
            redirect_to user_path( params[:user_id] )
        else
            render action: :new
        end
    end
    
    #GET request for users/:user_id/profile/edit
    def edit
        @user = User.find(params[:user_id])
        @profile = @user.profile
    end
    
    #PUT to /users/:user_id/profile
    def update
        @user = User.find(params[:user_id])
        @profile = @user.profile
        if @profile.update_attributes(profile_params)
            flash[:success] = "Perfil actualizado!"
            redirect_to user_path(id: params[:user_id])
        else
            render action: :edit
        end
    end
    
    private
        def profile_params
        params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
        end
end