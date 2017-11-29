class User < ApplicationRecord
  before_validation :ensure_session_token
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: { message: "Password can't be blank" }
  validates :password, length: { minimum: 6, allow_nil: true }

  def self.find_by_credentials(username, password)
    user = User.where(username: username).first
    user.password_digest.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def reset_session_token!
    self.session_token = nil
    save!
  end

  def password
    # `nil` after response cycle: doesn't persist
    @password
  end

  def password=(plaintext)
    @password = plaintext # -> validation
    self.password_digest = BCrypt::Password.create(plaintext)
  end

  def is_password?(password)
    # `self.password_digest` and `password` are strings, but re-instantiate
    # the digest as an object so BCrypt can read the metadata to build & compare digests
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
