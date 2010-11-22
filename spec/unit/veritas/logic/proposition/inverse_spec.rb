require 'spec_helper'

describe 'Veritas::Logic::Proposition#inverse' do
  subject { object.inverse }

  let(:klass)            { Class.new(Logic::Proposition)                        }
  let(:inverse_class)    { mock('Inverse Class', :instance => inverse_instance) }
  let(:inverse_instance) { mock('Inverse Instance')                             }
  let(:object)           { klass.new                                            }

  before do
    klass.stub!(:inverse).and_return(inverse_class)
  end

  it 'calls .inverse on the class' do
    klass.should_receive(:inverse).with(no_args).and_return(inverse_class)
    subject
  end

  it 'calls .instance on the inverse class' do
    inverse_class.should_receive(:instance).with(no_args)
    subject
  end

  it { should equal(inverse_instance) }
end
