module Guillotine
  module Adapters
    class SequelAdapter < Adapter
      def initialize(db)
        @db = db
        @table = @db[:urls]
      end
      
      # Public: Stores the shortened version of a URL.
      # 
      # url - The String URL to shorten and store.
      #
      # Returns the unique String code for the URL.  If the URL is added
      # multiple times, this should return the same code.
      def add(url)
        if row = @table.select(:code).where(:url => url).first
          row[:code]
        else
          code = shorten url
          @table << {:url => url, :code => code}
          code
        end
      end

      # Public: Retrieves a URL from the code.
      #
      # code - The String code to lookup the URL.
      #
      # Returns the String URL.
      def find(code)
        if row = @table.select(:url).where(:code => code).first
          row[:url]
        end
      end

      def setup
        @db.create_table :urls do
          string :url
          string :code

          unique :url
          unique :code
        end
      end
    end
  end
end