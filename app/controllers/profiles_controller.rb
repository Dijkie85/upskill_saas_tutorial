class ProfilesController < ApplicationController
    def new
        # Render blank profile form
        @profile = Profile.new
    end
end