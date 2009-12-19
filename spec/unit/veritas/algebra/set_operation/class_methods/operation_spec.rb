require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::SetOperation.operation' do
  subject { SetOperationSpecs::Object.operation }

  it { method(:subject).should raise_error(NotImplementedError, 'SetOperationSpecs::Object.operation must be implemented') }
end
