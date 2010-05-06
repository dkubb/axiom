require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::Match#inspect' do
  let(:attribute) { Attribute::String.new(:name) }
  let(:match)     { attribute.match(/Dan Kubb/)  }

  subject { match.inspect }

  it { should == "#{attribute.inspect} =~ #{/Dan Kubb/.inspect}" }
end
