# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mySite_session',
  :secret      => 'bb360d7cb8da44304fa6739c9ea7bc7afe76e91113cc75dbc6a685cc7bb6610e9ec85b15d3b2b1138974266c25f0e7b905ffc2d2c6dac219cdbd022a343d2972'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
