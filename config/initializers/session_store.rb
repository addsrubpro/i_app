# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_i_app_session',
  :secret      => '10993e05895280cec321370ea6ebd335b6d425df0728a039db2b3c7f4b474b9db17eb7215a930f77708c8f52aa16eb632d7589d0dea82afafbf85832d70e661a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
