require 'spec_helper'

describe 'Veritas::Logic::Predicate::LessThan#inspect' do
  subject { object.inspect }

  let(:klass)     { Logic::Predicate::LessThan  }
  let(:attribute) { Attribute::Integer.new(:id) }
  let(:object)    { klass.new(attribute, 1)     }

  it { should == "#{attribute.inspect} < 1" }
end
