require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate.eval' do
  subject { Logic::Predicate.eval(1, 1) }

  it { method(:subject).should raise_error(NotImplementedError, 'Veritas::Logic::Predicate.eval must be implemented') }
end
