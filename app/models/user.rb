class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  belongs_to :plan
  
  # Extend Devise user registrations so that pro users save with special stripe
  # Otherwise, Devise saves as usual
  attr_accessor :stripe_card_token
  
  def save_with_subscription
  # If pro users pass validations, call Stripe and have it set a monthly subscription 
  # Stripe responds with customer data and we store in the DB
    if valid?
      customer = Stripe::Customer.create(description: email, plan: plan_id, source: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  end
end

  