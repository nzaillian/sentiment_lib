require File.expand_path('../../strategy', __FILE__)

module SentimentLib
  module Analysis
    module Strategies
      class BasicDictStrategy < ::SentimentLib::Analysis::Strategy
        @@mappings = nil
        @@delims = [" ", "'", ";", ".", "-"]

        def initialize
          self.class._load_mappings if !@@mappings
        end

        def mappings
          @@mappings
        end

        private

        def self._load_mappings
          @@mappings = {}

          data_root = File.expand_path('../../../../sentiment_lib/data', __FILE__)
          
          word_file = File.new("#{data_root}/analysis/basic_dict/words.txt", 'r')

          while (line = word_file.gets)
            tokens = line.chomp.split("\t")
            @@mappings[tokens[1]] = tokens[0].to_f
          end

          word_file.close
        end
      end
    end
  end
end