require 'spec_helper'

describe 'Veritas::Logic::Predicate::Match#inspect' do
  subject { match.inspect }

  let(:attribute) { Attribute::String.new(:name) }
  let(:match)     { attribute.match(/Dan Kubb/)  }

  it { should == "#{attribute.inspect} =~ #{/Dan Kubb/.inspect}" }
end
