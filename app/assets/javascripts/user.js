/* global $, Stripe */

//Document ready
$(document).on('turbolinks:load', function() {
    var theForm = $('#pro_form');
    var submitBtn = $('#form-signup-btn');
    //Set Stripe public key
    Stripe.setPublishableKey ( $('meta[name="stripe-key"]').attr('content') );

    //When user clicks submit btn
    //prevent default subsmission behavior.
    submitBtn.click(function(event){ 
        event.preventDefault();
        submitBtn.val("Procesando...").prop('disabled', true);
        
        //Collect CC fields
        var ccNum = $('#card_number').val(),
            cvcNum = $('#card_code').val(),
            expMonth = $('#card_month').val(),
            expYear = $('#card_year').val();
        
        //Use Stripe JS library to check for card errors
        var error = false;
        
        //Validate card number
        if (!Stripe.card.validate.cardNumber(ccNum)) {
            error = true;
            alert('El número de tarjeta ingresado es inválido');
        }
        
        //Validate CVC number
        if (!Stripe.card.validate.cardCVC(cvcNum)) {
            error = true;
            alert('El CVC ingresado es inválido');
        }
        
        //Verify expiry date
        if (!Stripe.card.verifyExpiry(expMonth, expYear)) {
            error = true;
            alert('La fecha de expiración ingresada es inválida');
        }
        
        
        //If there are errors, don't send data to Stripe
        if (error) {
            submitBtn.prop('disabled', false).val("Registrarse");
            
        }
        
        else {
            //Send CC fields to Stripe
            Stripe.createToken({
                number: ccNum,
                cvc: cvcNum,
                exp_month: ExpMonth,
                exp_year: ExpYear
            }, stripeResponseHandler);
        }
        
        return false;
        
    });
        //Stripe will send card token back
        function stripeResponseHandler(status, response) {
            //Get the token from the response
            var token = response.id;
            
            //Inject card token as hidden field
            theForm.append( $('<input type="hidden" name="user[stripe_card_token]">').val(token) );
            //Submit form to rails app
            theForm.get(0).submit();
        }
      
    });
    
    
    
    

});