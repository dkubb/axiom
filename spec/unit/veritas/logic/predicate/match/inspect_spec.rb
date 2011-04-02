require 'spec_helper'

describe Logic::Predicate::Match, '#inspect' do
  subject { object.inspect }

  let(:klass)     { Logic::Predicate::Match          }
  let(:attribute) { Attribute::String.new(:name)     }
  let(:object)    { klass.new(attribute, /Dan Kubb/) }

  it { should == "#{attribute.inspect} =~ #{/Dan Kubb/.inspect}" }
end
