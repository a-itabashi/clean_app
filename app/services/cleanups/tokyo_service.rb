require 'net/http'
require 'json'

module Cleanups
  class TokyoService

    def initialize

      unless Date.today.workday? 
        exit
      end

      @day = Time.now.strftime("%-m月%-d日")

      @person, @what_tomorrow = case Time.zone.today.strftime("%a")
                                  when "Sun" then ["鈴木", "資源ごみ"]
                                  when "Tue" then ["渡邊", "火曜のゴミ"]
                                  when "Wed" then ["佐藤", "水曜のゴミ"]
                                  when "Thu" then ["田中", "燃えるゴミ"]
                                  when "Fri" then ["板橋", "プラスチックゴミ"]
                                end
    end

    def run
      access_url = ENV["ACCESS_URL"]
      uri = URI.parse(access_url)

      http = Net::HTTP.new(uri.host, uri.port).tap do |this|
        this.use_ssl = true
        this.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      req = Net::HTTP::Post.new(uri.request_uri)
      req['Content-Type'] = 'application/json'
      form_data = {"text": "#{@day}の部屋掃除は #{@person}さんです。\n明日は#{@what_tomorrow}の日なので夜には出しましょう。\nゴミの掃除当番の方が確認してください。"}

      req.body = form_data.to_json
      http.request(req)
    end
  end
end