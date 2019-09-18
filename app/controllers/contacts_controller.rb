class ContactsController < ApplicationController
   def new
      @contact = Contact.new
   end
   
   def create
      @contact = Contact.new(contact_params)
      if @contact.save
         flash[:success] = "Mensaje enviado. Muchas gracias."
         name = params[:contact][:name]
         email = params[:contact][:email]
         body = params[:contact][:comments]
         ContactMailer.contact_email(name, email, body).deliver
         redirect_to new_contact_path
      else
         flash[:danger] = "Ocurrió un error: " + @contact.errors.full_messages.join(", ")
         redirect_to new_contact_path
      end
   end 
      
   private 
      def contact_params
         params.require(:contact).permit(:name, :email, :comments)
      end
   
end