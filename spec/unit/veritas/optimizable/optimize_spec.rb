require 'spec_helper'

describe 'Veritas::Optimizable#optimize' do
  subject { object.optimize }

  let(:klass)  { Class.new { include Optimizable } }
  let(:object) { klass.new                         }

  it { should equal(object) }

  it_should_behave_like 'an optimize method'
end
