Dir[File.expand_path("../analysis/strategies/**/*.rb", __FILE__)].each { |f| require f }

module SentimentLib
  class Analyzer
    attr_accessor :strategy

    def initialize(opts={})
      @strategy = opts[:strategy] || ::SentimentLib::Analysis::Strategies::FinancialDictStrategy.new
    end

    def analyze(str, opts={})
      tokens = @strategy.tokenize(@strategy.normalize(str))

      @strategy.weigh(tokens)
    end
  end
end