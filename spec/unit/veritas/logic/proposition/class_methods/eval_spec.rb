require 'spec_helper'

describe 'Veritas::Logic::Proposition.eval' do
  subject { Logic::Proposition.eval }

  specify { expect { subject }.to raise_error(NotImplementedError, 'Veritas::Logic::Proposition.eval must be implemented') }
end
