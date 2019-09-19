class ContactsController < ApplicationController
   # GET request to /contact-us
   # Show new form (empty)
   def new
      @contact = Contact.new
   end
   
   # POST request /contacts
   def create
      # Mass asignment to @contact instance variable
      @contact = Contact.new(contact_params)
      
      # Save the Contact object parameters to @contact
      if @contact.save
         # Store form fields via params, into variables
         name = params[:contact][:name]
         email = params[:contact][:email]
         body = params[:contact][:comments]
         # Plug variables into ContactMailer, email method and send email
         ContactMailer.contact_email(name, email, body).deliver
         
         flash[:success] = "Mensaje enviado. Muchas gracias."
         redirect_to new_contact_path
      else
         #If Contact object doesn't save, store errors in flash-hash
         flash[:danger] = "Ocurrió un error: " + @contact.errors.full_messages.join(", ")
         redirect_to new_contact_path
      end
   end 
      
   # Use strong parameters to white list form fields
   private 
      def contact_params
         params.require(:contact).permit(:name, :email, :comments)
      end
   
end