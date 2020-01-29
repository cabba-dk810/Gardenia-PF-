# frozen_string_literal: true

require 'json'
require 'uri'
require 'net/https'
module Translation
  class << self
    def get_label_data(label_word)
      api_url = "https://translation.googleapis.com/language/translate/v2?key=#{ENV['GOOGLE_API_KEY']}"
      # APIリクエスト用のJSONパラメータ
      params = {
        q: label_word,
        target: 'ja',
        source: 'en'
      }.to_json
      # Google Cloud Vision APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)
      # APIレスポンス出力
      JSON.parse(response.body)['data']['translations'][0]['translatedText']
    end
  end
end
