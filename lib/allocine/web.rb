module Allocine
  class Web
    attr_reader :data
    def initialize(urls)
      @data = download(urls)
    end
  end
end