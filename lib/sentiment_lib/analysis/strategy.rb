module SentimentLib
  module Analysis
    class Strategy 

      def normalize(str)
        str.gsub(/[^[:alnum:]]/, ' ').downcase
      end

      def tokenize(str)
        str.split
      end 

      # default weight is an average of per-word
      # weight.  Optionally override in derived strategies.
      def weigh(tokens)
        valid_tokens = tokens.delete_if { |token|
          mappings[token] == nil
        }

        return 0 if valid_tokens.length == 0

        sum = 0

        valid_tokens.each { |token| 
          sum += mappings[token]
        }

        avg = sum / valid_tokens.length

        avg          
      end
    end
  end
end