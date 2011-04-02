require 'spec_helper'

describe Logic::Predicate::NoMatch, '#inspect' do
  subject { object.inspect }

  let(:klass)     { Logic::Predicate::NoMatch        }
  let(:attribute) { Attribute::String.new(:name)     }
  let(:object)    { klass.new(attribute, /Dan Kubb/) }

  it { should == "#{attribute.inspect} !~ #{/Dan Kubb/.inspect}" }
end
