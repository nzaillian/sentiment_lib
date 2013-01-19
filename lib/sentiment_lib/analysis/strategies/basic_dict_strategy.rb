require File.expand_path('../../strategy', __FILE__)

module SentimentLib
  module Analysis
    module Strategies
      class BasicDictStrategy < ::SentimentLib::Analysis::Strategy
        @@mappings = nil

        def initialize
          self.class._load_mappings if !@@mappings
        end

        def mappings
          @@mappings
        end

        # weight is pure sum (not average)
        def weigh(tokens, opts={})
          valid_tokens = tokens.delete_if { |token|
            mappings[token] == nil
          }

          return 0 if valid_tokens.length == 0

          sum = 0

          valid_tokens.each { |token| 
            sum += mappings[token]
          }

          if opts[:average] == true
            sum / valid_tokens.length
          else
            sum
          end
        end         

        private

        def self._load_mappings
          @@mappings = {}

          data_root = File.expand_path('../../../../sentiment_lib/data', __FILE__)
          
          word_file = File.new("#{data_root}/analysis/basic_dict/words.txt", 'r')

          while (line = word_file.gets)
            tokens = line.chomp.split("\t")
            @@mappings[tokens[1].stem] = tokens[0].to_f
          end

          word_file.close
        end
      end
    end
  end
end