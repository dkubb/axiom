require 'spec_helper'

describe 'Veritas::Immutable::Memory#[]' do
  subject { memory[key] }

  let(:memory) { Immutable::Memory.new }

  context 'with known key' do
    let(:key)   { '@key'        }
    let(:value) { mock('Value') }

    before do
      memory.instance_variable_set(key, value)
    end

    it { should equal(value) }
  end

  context 'with unknown key' do
    let(:key) { '@key' }

    it { should be_nil }
  end
end
