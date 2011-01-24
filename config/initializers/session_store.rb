# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_testrails_session',
  :secret      => '7e927fce088d8ba5b145aa0ea3c9492f5d024435581929ed8f498f2ecb320479eba36174869e0d98ad0b2753cb8b32757f740cd5ae9b5e65a9b83b6b6a564590'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
