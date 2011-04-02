require 'spec_helper'

describe Logic::Predicate::NoMatch, '#inspect' do
  subject { object.inspect }

  let(:attribute) { Attribute::String.new(:name)               }
  let(:object)    { described_class.new(attribute, /Dan Kubb/) }

  it { should == "#{attribute.inspect} !~ #{/Dan Kubb/.inspect}" }
end
