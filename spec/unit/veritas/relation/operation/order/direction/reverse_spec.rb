require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::Direction#reverse' do
  subject { object.reverse }

  let(:klass)         { Class.new(Relation::Operation::Order::Direction) }
  let(:attribute)     { Attribute::Integer.new(:id)                      }
  let(:reverse_class) { mock('Reverse Class', :new => reverse)           }
  let(:reverse)       { mock('Reverse Instance')                         }
  let(:object)        { klass.new(attribute)                             }

  before do
    klass.stub!(:reverse).and_return(reverse_class)
  end

  it 'calls .reverse on the class' do
    klass.should_receive(:reverse).with(no_args)
    subject
  end

  it 'calls .new on the reverse class' do
    reverse_class.should_receive(:new).with(attribute)
    subject
  end

  it { should equal(reverse) }
end
