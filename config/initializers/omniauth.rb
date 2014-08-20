Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "711cfbffc8b14c8b8ff4d8ed7c84f94f", "afc2160151c341d298755de3c8e28270", scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end