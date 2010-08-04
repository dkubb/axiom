require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::Direction#reverse' do
  subject { direction.reverse }

  let(:attribute)        { Attribute::Integer.new(:id)                      }
  let(:klass)            { Class.new(Relation::Operation::Order::Direction) }
  let(:direction)        { klass.new(attribute)                             }
  let(:reverse_class)    { mock('Reverse Class', :new => reverse_instance)  }
  let(:reverse_instance) { mock('Reverse Instance')                         }

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

  it { should equal(reverse_instance) }
end
