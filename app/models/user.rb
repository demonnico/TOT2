class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable
  # attr_accessible :title, :body

  attr_accessible :email, :password, :password_confirmation, :remember_me

  def admin?
    return self.is_admin
  end

  def set_is_admin(boolean)
  	self.is_admin = boolean if !!boolean == boolean #make sure new boolean value is a boolean
  end
end
