require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

#def complement
#  self.class.complement.instance
#end

describe 'Veritas::Logic::Proposition#complement' do
  subject { proposition.complement }

  let(:klass)               { Class.new(PropositionSpecs::Object)                        }
  let(:proposition)         { klass.new                                                  }
  let(:complement_class)    { mock('Complement Class', :instance => complement_instance) }
  let(:complement_instance) { mock('Complement Instance')                                }

  before do
    klass.stub!(:complement).and_return(complement_class)
  end

  it 'calls .complement on the class' do
    klass.should_receive(:complement).with(no_args).and_return(complement_class)
    subject
  end

  it 'calls .instance on the complement class' do
    complement_class.should_receive(:instance).with(no_args)
    subject
  end

  it { should equal(complement_instance) }
end
