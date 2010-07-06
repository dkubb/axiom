require 'spec_helper'

describe 'Veritas::Logic::Predicate::NoMatch#inspect' do
  subject { no_match.inspect }

  let(:attribute) { Attribute::String.new(:name)   }
  let(:no_match)  { attribute.no_match(/Dan Kubb/) }

  it { should == "#{attribute.inspect} !~ #{/Dan Kubb/.inspect}" }
end
