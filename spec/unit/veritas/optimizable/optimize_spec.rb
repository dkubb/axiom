require File.expand_path('../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Optimizable#optimize' do
  before do
    @optimizable = OptimizableSpecs::Object.new
  end

  subject { @optimizable.optimize }

  it { should equal(@optimizable) }
end
