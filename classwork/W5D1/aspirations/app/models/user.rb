class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}
  attr_reader :password
  
  after_initialize :ensure_session_token
  
  has_many :goals
  # def completed_goals
  #   @completed_goals ||= goals.where(completed: true)
  # end
  # has_many :comments
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    
    return nil unless user
    return user if user.is_password?(password)  
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def ensure_session_token
    self.session_token ||= generate_session_token
  end
  
  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
    self.session_token
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end  
  
  private
  
  def generate_session_token
    SecureRandom.urlsafe_base64
  end
end
 