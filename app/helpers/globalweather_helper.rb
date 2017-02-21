module GlobalweatherHelper
    require 'savon'
    require 'nokogiri'
    @@client = Savon.client(wsdl: 'http://www.webservicex.net/globalweather.asmx?wsdl')

    def self.get_cities_by_country(country_name)
        response = @@client.call(:get_cities_by_country, message: { 'CountryName' => country_name })
        parse_xml_doc(response.body[:get_cities_by_country_response][:get_cities_by_country_result], '//City')
    end

    def self.get_weather(params)
        response = @@client.call(:get_weather, message: { 'CountryName' => params[:country_name], 'CityName'=> params[:city_name] })
        if response.body[:get_weather_response][:get_weather_result] == 'Data Not Found'
            "No Weather Data Found"
        else
            response.body[:get_weather_response][:get_weather_result]
        end
    end

    private

    def self.parse_xml_doc(xml_string, xpath)
        elements = Nokogiri::XML(xml_string).xpath(xpath).map { |el| el.content}
        elements.sort
    end

end
