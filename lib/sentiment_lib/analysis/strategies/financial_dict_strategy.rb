require File.expand_path('../../strategy', __FILE__)

module SentimentLib
  module Analysis
    module Strategies
      class FinancialDictStrategy < ::SentimentLib::Analysis::Strategy
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
          
          positive_word_file = File.new("#{data_root}/analysis/financial_dict/positive.csv", 'r')
          negative_word_file = File.new("#{data_root}/analysis/financial_dict/negative.csv", 'r')

          while (line = positive_word_file.gets)
            tokens = line.chomp.split(",")
            @@mappings[tokens[0].downcase] = 1.0
          end

          while (line = negative_word_file.gets)
            tokens = line.chomp.split(",")
            @@mappings[tokens[0].downcase] = -1.0
          end            

          [positive_word_file, negative_word_file].map &:close
        end
      end
    end
  end
end