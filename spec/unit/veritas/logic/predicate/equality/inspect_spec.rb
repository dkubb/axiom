require 'spec_helper'

describe Logic::Predicate::Equality, '#inspect' do
  subject { object.inspect }

  let(:klass)     { Logic::Predicate::Equality  }
  let(:attribute) { Attribute::Integer.new(:id) }
  let(:object)    { klass.new(attribute, 1)     }

  it { should == "#{attribute.inspect} == 1" }
end
