module Allocine
  module WebCurb
    def download(urls)
      url_queue = [*urls]
      multi = Curl::Multi.new
      responses = {}
      url_queue.each do |url|
        easy = Curl::Easy.new(url) do |curl|
          curl.follow_location = true      
          curl.on_success do |c|
            responses[url] = decode_content(c)
          end
          curl.on_failure do |c, err|
            responses[url] = c.response_code
          end
        end
        multi.add(easy)
      end
      multi.perform
      urls.is_a?(String) ? responses.values.first : responses
    end

    def decode_content(c)
      if c.header_str.match(/Content-Encoding: gzip/)
        begin
          gz =  Zlib::GzipReader.new(StringIO.new(c.body_str))
          xml = gz.read
          gz.close
        rescue Zlib::GzipFile::Error 
          # Maybe this is not gzipped?
          xml = c.body_str
        end
      elsif c.header_str.match(/Content-Encoding: deflate/)
        xml = Zlib::Inflate.inflate(c.body_str)
      else
        xml = c.body_str
      end
      xml
    end

  end
end