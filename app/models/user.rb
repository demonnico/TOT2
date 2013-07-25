class User < ActiveRecord::Base

  before_save :default_values

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable
  # attr_accessible :title, :body

  attr_accessible :email, :password, :password_confirmation, :remember_me

  def set_role(integer)
    if roleAvailable? integer
      self.role = integer
    end
  end

  def default_values
    self.role ||= USER_ROLE_VIEWER
  end
end
