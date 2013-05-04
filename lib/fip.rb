require "fip/version"
require "base64"
require "httparty"

module Fip
  class Fip
    def initialize(email, passwd)
      @email = email
      @passwd = passwd
      @partition = read_partition
      @devices = read_devices
      puts locate
    end

    def read_partition
      body =  { "clientContext" => 
                { "appName"=>"FindMyiPhone",
                  "appVersion"=>"1.4",
                  "buildVersion"=>"145",
                  "deviceUDID"=>"0000000000000000000000000000000000000000",
                  "inactiveTime"=>2147483647,
                  "osVersion"=>"4.2.1",
                  "personID"=>0,
                  "productType"=>"iPad1,1"
                }
              }
      response = post("/fmipservice/device/#{@email}/initClient", body)
      response.headers["X-Apple-MMe-Host"]
    end

    def read_devices
      body = { "clientContext" =>
               { "appName"        => "FindMyiPhone",
                 "appVersion"     => "1.4",
                 "buildVersion"   => "145",
                 "deviceUDID"     => "0000000000000000000000000000000000000000",
                 "inactiveTime"   => 2147483647,
                 "osVersion"      => "4.2.1",
                 "personID"       => 0,
                 "productType"    => "iPad1,1"
               }
             }
      response = post("/fmipservice/device/#{@email}/initClient", body)
      if response["error"]
        puts "Error from web service: #{response["error"]}"
        return []
      end
      response["content"]
    end

    def locate(device_num=0)
      @devices = read_devices
      device = @devices[device_num]

      { 
        "latitude" => device["location"]["latitude"],
        "longitude" => device["location"]["longitude"],
        "accuracy" => device["location"]["horizontalAccuracy"],
        "timestamp" => device["location"]["timeStamp"]
      }

    end

    def post(url, body)
        if @partition
            url = "https://#{@partition}#{url}"
        else
            url = "https://fmipmobile.icloud.com#{url}"
        end

        headers = {
                    'Content-type'=> 'application/json; charset=utf-8',
                    'X-Apple-Find-Api-Ver'=> '2.0',
                    'X-Apple-Authscheme'=> 'UserIdGuest',
                    'X-Apple-Realm-Support'=> '1.0',
                    'User-agent'=> 'Find iPhone/1.2 MeKit (iPad: iPhone OS/4.2.1)',
                    'X-Client-Name'=> 'iPad',
                    'X-Client-UUID'=> '0cf3dc501ff812adb0b202baed4f37274b210853',
                    'Accept-Language'=> 'en-us',
                    'Connection'=> 'keep-alive',
                    'Authorization'=> "Basic " + Base64.encode64("#{@email}:#{@passwd}")
                  }


        resp = HTTParty.post(url, :query => body, :headers => headers)
    end
  end
end
