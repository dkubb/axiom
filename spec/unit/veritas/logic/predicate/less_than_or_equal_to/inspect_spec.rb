require 'spec_helper'

describe Logic::Predicate::LessThanOrEqualTo, '#inspect' do
  subject { object.inspect }

  let(:klass)     { Logic::Predicate::LessThanOrEqualTo }
  let(:attribute) { Attribute::Integer.new(:id)         }
  let(:object)    { klass.new(attribute, 1)             }

  it { should == "#{attribute.inspect} <= 1" }
end
