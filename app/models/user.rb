class User < ApplicationRecord
    attr_reader :password

    validates :email, :password_digest, :session_token, presence: true
    validates :email, :session_token, uniqueness: true
    validates :password, length:{ minimum: 8, allow_nil: true}

    after_initialize :ensure_session_token


    def self.find_by_credentials(email, password)
        @user = User.find_by(email: email)

        @user && @user.is_password?(password) ? @user : nil
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def reset_session_token!
        self.session_token = generate_unique_session_token
        self.save!

        self.session_token
    end

    def ensure_session_token
        self.session_token ||= generate_unique_session_token
    end


    def generate_unique_session_token
        token = SecureRandom.urlsafe_base64(16)

        while self.class.exists?(session_token: token)
            token = SecureRandom.urlsafe_base64(16)
        end

    token

    end
end