require File.expand_path('../../spec_helper', __FILE__)

describe ::SentimentLib::Analyzer do
  it "should initialize" do
    a = SentimentLib::Analyzer.new
    a.should_not == nil and a.class.should == SentimentLib::Analyzer
  end

  it "should correctly evaluate a test string with the FinancialDictStrategy" do
    a = SentimentLib::Analyzer.new
    a.analyze("I'm feeling confident and excited this morning!").should == 2.0
  end  

  it "should correctly evaluate a test string with the BasicDictStrategy" do
    a = SentimentLib::Analyzer.new(:strategy => ::SentimentLib::Analysis::Strategies::BasicDictStrategy.new)
    a.analyze("Tom is righteous and idealistic.").should == 1.5625
  end    
end