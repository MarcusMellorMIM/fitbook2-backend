require 'net/http'
require 'json'
require 'net/https'


class NutritionixAPI

  # Please note the NUTRIONIX_APIKEY and the NUTRIONIX_APPID need to be set 
# as environment variables, that you can get from nutrionix as part of their developer
# program

  def self.get_mealinfo(detail)
# Returns a hash of individual components of a free text get_meal
# using the nutrionix api

    @body = {
      "query" => detail,
      "timezone" => "US/Eastern"
    }.to_json

    uri = URI.parse("https://trackapi.nutritionix.com/v2/natural/nutrients")
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, initheader = {'x-app-key' => ENV["NUTRIONIX_APIKEY"], 'x-app-id' =>  ENV["NUTRIONIX_APPID"], 'Content-Type' =>'application/json'})
    req.body = @body
    res = https.request(req)
  #puts "Response #{res.code} #{res.message}: #{res.body}"
    JSON.parse(res.body)["foods"]

  end

  def self.get_exerciseinfo( detail, gender, weight_kg, height_cm, age_years )
# Returns details of free text exerise.
# It requires a persons details to calculate calorie burn
# Possibly should just use a user object, and get the rest of the stuff internally

    @body = {
      "query" => detail,
      "gender" => gender,
      "weight_kg" => weight_kg,
      "height_cm" => height_cm,
      "age" => age_years
    }.to_json

    uri = URI.parse("https://trackapi.nutritionix.com/v2/natural/exercise")
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, initheader = {'x-app-key' => 'c1c9449f86cac6f5c48e9da9eb390dc5', 'x-app-id' =>  '2d7f68ea', 'Content-Type' =>'application/json'})
    req.body = @body
    res = https.request(req)
    JSON.parse(res.body)["exercises"]

  end

end