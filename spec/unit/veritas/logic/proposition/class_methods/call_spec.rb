require 'spec_helper'

describe Logic::Proposition, '.call' do
  subject { object.call }

  let(:object) { described_class }

  specify { expect { subject }.to raise_error(NotImplementedError, "#{object}.call must be implemented") }
end
