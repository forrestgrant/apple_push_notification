require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'rails/all'
require 'sqlite3'
gem 'activerecord', '= 3.0.7'

ENV["RAILS_ENV"] ||= 'test'
Rails.env = 'test'

require 'apple_push_notification'

MY_DB_NAME = "test.db"
MY_DB = SQLite3::Database.new(MY_DB_NAME)
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => MY_DB_NAME)
class User < ActiveRecord::Base
  acts_as_pushable
end

ActiveRecord::Schema.define(:version => 1) do
  unless User.table_exists? 
    create_table :users do |t|
      t.string :name
      t.string :token
    end
    
    User.create({:name => 'foo', :token => 'bar'})
  end
end

RSpec.configure do |config|
  
end