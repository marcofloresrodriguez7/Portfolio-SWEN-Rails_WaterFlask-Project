class HomeController < ApplicationController

	

  def index
  	require 'net/http'
  	require 'json'
  	require 'openssl'
 
  	@url = 'http://api.openweathermap.org/data/2.5/weather?zip=77080,us&units=imperial&APPID=7213276d8be9af9fb6bec1576093ea7a'
  	@uri = URI(@url)

  	http = Net::HTTP.new(@uri.host, @uri.port)
  	http.use_ssl = true
  	http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  	@response = Net::HTTP.get(@uri)
  	@output = JSON.parse(@response)

  	if @output["cod"] == "404"
  		@color_output = "Error"
  		@final_output = "Error, please check your Zipcode!"
  	else
  		@color_output = Float(@output["main"]["temp"])
  		@final_output = "#{@output["main"]["temp"]}  degrees Fahrenheit, is the current temperature in your neighborhood (Zipcode: 77080)."
  	end 

  	if @color_output == "Error"
  		@api_color = "grey"
    elsif @color_output >= 90.0  
  		@api_color = "red"
  	
   	elsif @color_output < 90.0 && @color_output >= 65.0 
  		@api_color = "orange"

  	elsif @color_output < 65.0 && @color_output >= 32.0 
  		@api_color = "blue"

  	elsif @color_output < 32.0
  		@api_color = "lightblue"
  
  	end

  end

  def zipcode
    @zip_query = params[:zipcode]
    if params[:zipcode] == ""
      @final_output = "Error, Zipcode was not entered!"
    
    elsif params[:zipcode]
      require 'net/http'
      require 'json'
      require 'openssl'
   
      @url = 'http://api.openweathermap.org/data/2.5/weather?zip=' + @zip_query + ',us&units=imperial&APPID=7213276d8be9af9fb6bec1576093ea7a'
      @uri = URI(@url)

      http = Net::HTTP.new(@uri.host, @uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      @response = Net::HTTP.get(@uri)
      @output = JSON.parse(@response)

      if @output["cod"] == "404"
        @color_output = "Error"
        @final_output = "Error, please check your Zipcode!"
      else
        @color_output = Float(@output["main"]["temp"])
        @final_output = "#{@output["main"]["temp"]}  degrees Fahrenheit, is the current temperature in your neighborhood (Zipcode: #{@zip_query})."
      end 

      if @color_output == "Error"
        @api_color = "grey"
      elsif @color_output >= 90.0  
        @api_color = "red"
      
      elsif @color_output < 90.0 && @color_output >= 65.0 
        @api_color = "orange"

      elsif @color_output < 65.0 && @color_output >= 32.0 
        @api_color = "blue"

      elsif @color_output < 32.0
        @api_color = "lightblue"
    
      end 
    end 
  end 
end
