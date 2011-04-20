require 'spec_helper'

describe Logic::Predicate, '.call' do
  subject { object.call(left, right) }

  let(:left)   { 1               }
  let(:right)  { 1               }
  let(:object) { described_class }

  specify { expect { subject }.to raise_error(NotImplementedError, "#{object}.call must be implemented") }
end
