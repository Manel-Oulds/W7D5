class User < ApplicationRecord
    validates :username, :session_token, presence:true , uniqueness: true
    validates :password, length: {minimum:6}, allow_nil:true
    validates :password_digest, presence:true

    #FIGVAPER

    attr_reader :password
    before_validation :ensure_session_token

    def password=(password)
        @password=password
        self.password_digest = BCrypt::Password.create(password)
    end

    def self.find_by_credentials(username,password)
        user = User.find_by(username: username)
        if user && user.is_password?(password)
            return user
        else
            nil
        end
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def generate_unique_session_token
        loop do 
            session_token = SecureRandom::urlsafe_base64(6)
            return session_token unless User.exists?(session_token: session_token)
        end
    end

    def ensure_session_token
        
        self.session_token ||= generate_unique_session_token
        # debugger
    end

    def reset_session_token
        self.session_token = generate_unique_session_token
        self.save!
        self.session_token
    end


end
