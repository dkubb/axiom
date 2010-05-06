require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate.range_or_value' do
  subject { Logic::Predicate.range_or_value(value, method) }

  describe 'with an Attribute' do
    let(:attribute) { Attribute::Integer.new(:id, :size => 1..10) }
    let(:value)     { attribute                                   }
    let(:method)    { :last                                       }

    it 'executes the method on attribute range' do
      should == 10
    end
  end

  describe 'with a value' do
    let(:value)  { 5     }
    let(:method) { :last }

    it 'executes the method on attribute range' do
      should == 5
    end
  end
end
