# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_MigrationExamples_session',
  :secret      => 'b8a6083411bb0edb8d65d115785a682628cf0cd8715da8ae7e821f97323dee358a819772694365f36b9ef5a959a329ee4a8e1daee3e64b7c2fc2b9d41c2f1144'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
