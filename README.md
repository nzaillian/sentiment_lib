# SentimentLib

A simple, extensible sentiment analysis gem.

## Installation

Add this line to your application's Gemfile:

    gem 'sentiment_lib'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sentiment_lib

## Usage

SentimentLib exposes simple sentiment analysis via SentimentLib::Analyzer.

example usage --

    analyzer = SentimentLib::Analyzer.new

    analyzer.analyze("I'm feeling confident and excited this morning!")
    => 2.0


The library ships with two analysis strategies (you will liklely want to add your own domain-specific strategies):

    SentimentLib::Analysis::Strategies::BasicDictStrategy

and

    SentimentLib::Analysis::Strategies::FinancialDictStrategy

The first (BasicDictStrategy) uses a dictionary file (at lib/sentiment_lib/data/analysis/basic_dict/words.txt) mapping words to decimal weights between -1.0 and 1.0.  It's analysis is the average of word weights for the supplied string.

The second (FinancialDictStrategy) uses the Loughran and McDonald Financial Sentiment Dictionary with +1 and -1 weights mapped to the dictionary's positive and negative words, respectively.  It's analysis is the sum of word weights for the supplied string.

The API for adding your own analysis strategies is straightforward:

create a subclass of SentimentLib::Analysis::Strategy

  implement the following public instance methods (all but first optional):

  required: 
    
    mappings
      returns a hash mapping token strings to weights
      
      ex:
      
      {
        "happy" => 1.0,
        "sad" => -1.0
      }

      The supplied strategies both load text files with
      word-weight mappings and parse them into a hash.

  optional:

    normalize(str)
      Normalize the string to be analyzed (applied before tokenization - see below).
      Default is to downcase and strip all alphanumeric characters.

    tokenize(str)
      Defines custom method for converting the string being analyzed (str) into 
      tokens (default splits on white space).

    weigh(tokens)
      Define custom method for weighing the collected tokens of the string
      (default is to average token weights).


You can then pass your strategy to new instances of SentimentLib::Analyzer:

    analyzer = SentimentLib::Analyzer.new(:strategy => MyCustomStrategy.new)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request