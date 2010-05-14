require 'spec_helper'

describe 'Veritas::Logic::Predicate.eval' do
  subject { Logic::Predicate.eval(1, 1) }

  specify { method(:subject).should raise_error(NotImplementedError, 'Veritas::Logic::Predicate.eval must be implemented') }
end
