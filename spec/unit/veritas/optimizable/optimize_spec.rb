require File.expand_path('../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Optimizable#optimize' do
  let(:optimizable) { OptimizableSpecs::Object.new }

  subject { optimizable.optimize }

  it { should equal(optimizable) }
end
