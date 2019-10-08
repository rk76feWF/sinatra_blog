require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']||"sqlite3:db/development.db")

class User < ActiveRecord::Base
  has_secure_password
  validates :user_email,
    presence: true,
    format: {with:/.+@.+/},
    uniqueness: true
  validates :password,
  length: {in: 3..100}

  has_many :articles
end

class Article < ActiveRecord::Base
  belongs_to :user

end