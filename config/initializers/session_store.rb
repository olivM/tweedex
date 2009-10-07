# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_tweedex_session',
  :secret      => '94c64db42a4463bf48cb8367c581c2e020af5c9bc3763a9229df418ea6ecdb71e92b3931a23be2488bdc8fb6f0684365e13e0c62d92b2ce6038bb99489b47125'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
