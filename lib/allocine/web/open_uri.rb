module Allocine
  module WebOpenUri
    def download(urls)
      responses = {}
      [*urls].each do |url|
        responses[url] = open(url).read.to_s
      end
      urls.is_a?(String) ? responses.values.first : responses
    end
  end
end