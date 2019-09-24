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
            redirect_to root_path
        else
            render action: :new
        end
    end
    
    private
        def profile_params
        params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
        end
end