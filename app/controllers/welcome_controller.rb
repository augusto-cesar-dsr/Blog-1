class WelcomeController < ApplicationController
  def index
    @name = "Caruso"
    @date_ambience = Date.today
    # @locale_is = locale(I18n.locale) esse método não funciona
  end
end
