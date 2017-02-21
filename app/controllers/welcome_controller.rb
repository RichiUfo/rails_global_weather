class WelcomeController < ApplicationController

    def index
        @countries = list = ISO3166::Country.all.sort
    end

    def get_cities
        @cities = GlobalweatherHelper.get_cities_by_country(weaher_params[:country_name])
        render :layout => false
    end

    def get_weather
        @weather = GlobalweatherHelper.get_weather(weaher_params)
        render :layout => false
    end

    def weaher_params
        params.permit(:country_name, :city_name)
    end

end
