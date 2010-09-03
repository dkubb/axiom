require 'spec_helper'

describe 'Veritas::Logic::Predicate.call' do
  subject { Logic::Predicate.call(1, 1) }

  specify { expect { subject }.to raise_error(NotImplementedError, 'Veritas::Logic::Predicate.call must be implemented') }
end
