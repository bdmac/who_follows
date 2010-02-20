# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_following_session',
  :secret      => 'e0ceea2967b66f3dc464d4c81140f15e02ef1be951169d343f9938a1982cb9a555fa2aaa665bf76a25ba1b78a8c39dc63cb4feeca593223868ee4d736432bedf'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
