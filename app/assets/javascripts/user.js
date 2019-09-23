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
        
        //Collect CC fields
        var ccNum = $('#card_number').val(),
            cvcNum = $('#card_code').val(),
            expMonth = $('#card_month').val(),
            expYear = $('#card_year').val();
        //Send CC fields to Stripe
        Stripe.createToken({
            number: ccNum,
            cvc: cvcNum,
            exp_month: ExpMonth,
            exp_year: ExpYear
            
            
        }, stripeResponseHandler);
      
    });
    
    
    //Stripe will send card token back
    //Inject card token as hidden field
    //Submit form to rails app

});