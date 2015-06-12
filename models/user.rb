class User < Sequel::Model
  ADMIN = "admin"
  USER = "user"
  plugin :validation_helpers

  attr_accessor :password, :password_confirmation

  def validate
    validates_presence     :email
    validates_presence     :role
    validates_presence     :password if password_required
    validates_presence     :password_confirmation if password_required
    validates_length_range 4..40, :password unless password.blank?
    errors.add(:password_confirmation, 'must confirm password') if !password.blank? && password != password_confirmation
    validates_length_range 3..100, :email unless email.blank?
    validates_unique       :email unless email.blank?
    validates_format       /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :email unless email.blank?
    validates_format       /[A-Za-z]/, :role unless role.blank?
  end

  # Callbacks
  def before_save
    encrypt_password
  end

  ##
  # This method is for authentication purpose.
  #
  def self.authenticate(email, password)
    user = filter(Sequel.function(:lower, :email) => Sequel.function(:lower, email)).first
    user && user.has_password?(password) ? user : nil
  end

  ##
  # Replace ActiveRecord method.
  #
  def self.find_by_id(id)
    self[id] rescue nil
  end

  def self.find_or_create_by_email(email, automatic_id=nil)
    self[email: email] || self.create(email: email, automatic_id: automatic_id, role: USER)
  end

  # omniauth_params.info
  # {email: "", first_name="", id="", last_name=""}
  # search based on the automatic_id and update first & lastname and email if needed
  def self.find_or_create_from_oauth(omniauth_params)
    omniauth = omniauth_params.info
    user = (self[automatic_id: omniauth_params.info["id"]] || self.new(
      { email: omniauth.email, first_name: omniauth.first_name, last_name: omniauth.last_name, automatic_id: omniauth.id, role: ADMIN }
    ))
    user
  end

  def has_password?(password)
    ::BCrypt::Password.new(self.crypted_password) == password
  end

  private

  def encrypt_password
    self.crypted_password = ::BCrypt::Password.create(password) if password.present?
  end

  def password_required
    return false if automatic_id.present?
    self.crypted_password.blank? || password.present?
  end
end
