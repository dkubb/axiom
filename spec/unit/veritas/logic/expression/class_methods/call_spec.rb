require 'spec_helper'

describe 'Veritas::Logic::Expression.call' do
  subject { object.call }

  let(:object) { Logic::Expression }

  specify { expect { subject }.to raise_error(NotImplementedError, "#{object}.call must be implemented") }
end
