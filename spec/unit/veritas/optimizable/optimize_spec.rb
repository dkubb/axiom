require 'spec_helper'

describe 'Veritas::Optimizable#optimize' do
  subject { optimizable.optimize }

  let(:klass)       { Class.new { include Optimizable } }
  let(:optimizable) { klass.new                         }

  it { should equal(optimizable) }

  it_should_behave_like 'an optimize method'
end
