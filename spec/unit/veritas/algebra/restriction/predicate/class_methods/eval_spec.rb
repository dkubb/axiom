require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Predicate.eval' do
  subject { Algebra::Restriction::Predicate.eval(1, 1) }

  it { method(:subject).should raise_error(NotImplementedError, 'Veritas::Algebra::Restriction::Predicate.eval must be implemented') }
end
