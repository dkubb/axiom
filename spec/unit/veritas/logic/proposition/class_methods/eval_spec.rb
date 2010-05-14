require 'spec_helper'

describe 'Veritas::Logic::Proposition.eval' do
  subject { Logic::Proposition.eval }

  specify { method(:subject).should raise_error(NotImplementedError, 'Veritas::Logic::Proposition.eval must be implemented') }
end
