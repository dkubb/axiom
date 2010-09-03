require 'spec_helper'

describe 'Veritas::Logic::Proposition.call' do
  subject { Logic::Proposition.call }

  specify { expect { subject }.to raise_error(NotImplementedError, 'Veritas::Logic::Proposition.call must be implemented') }
end
