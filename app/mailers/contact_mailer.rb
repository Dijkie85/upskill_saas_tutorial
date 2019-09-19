class ContactMailer < ActionMailer::Base
    default to: 'davidmielnik@gmail.com'
    
    def contact_email(name, email, body)
        @name = name
        @email = email
        @body = body
        
        mail(from: email, subject: 'Mensaje de contacto desde el formulario.')
    end
end
