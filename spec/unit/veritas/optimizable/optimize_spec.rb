require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Optimizable#optimize' do
  subject { optimizable.optimize }

  let(:optimizable) { OptimizableSpecs::Object.new }

  it { should equal(optimizable) }

  it_should_behave_like 'an optimize method'
end
