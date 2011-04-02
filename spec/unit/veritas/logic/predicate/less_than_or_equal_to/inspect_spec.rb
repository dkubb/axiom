require 'spec_helper'

describe Logic::Predicate::LessThanOrEqualTo, '#inspect' do
  subject { object.inspect }

  let(:attribute) { Attribute::Integer.new(:id)       }
  let(:object)    { described_class.new(attribute, 1) }

  it { should == "#{attribute.inspect} <= 1" }
end
