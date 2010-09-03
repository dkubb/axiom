require 'spec_helper'

describe 'Veritas::Optimizable::ClassMethods#optimizer' do
  subject { object.optimizer }

  let(:klass)  { Class.new { include Optimizable, Immutable } }
  let(:object) { klass                                        }

  context 'when the optimizer is not set' do
    it { should be_nil }
  end

  context 'when the optimizer is set' do
    let(:optimizer) { mock('Optimizer') }

    before do
      object.optimizer = optimizer
    end

    it { should equal(optimizer) }
  end
end

describe 'Veritas::Optimizable::ClassMethods#optimizer=' do
  subject { object.optimizer = optimizer }

  let(:klass)     { Class.new { include Optimizable, Immutable } }
  let(:optimizer) { mock('Optimizer')                            }
  let(:object)    { klass                                        }

  it 'sets the optimizer' do
    expect { subject }.to change { object.optimizer }.from(nil).to(optimizer)
  end
end
