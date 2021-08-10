# config/initializers/locale.rb

# Where the I18n library should search for translation files
# caso queira outros lugares para idiomas adicionais
#I18n.load_path += Dir[Rails.root.join('lib', 'library', '*.{rb,yml}')]

# Whitelist locales available for the application
I18n.available_locales = [:en,  "pt-BR"]

# Set default locale to something other than :en
I18n.default_locale = "pt-BR"