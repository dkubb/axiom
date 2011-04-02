require 'spec_helper'

describe Logic::Proposition, '#inspect' do
  subject { object.inspect }

  let(:described_class) { Class.new(Logic::Proposition) }
  let(:object)          { described_class.new           }

  before do
    described_class.stub!(:name).and_return('Veritas::Logic::Proposition')
  end

  specify { expect { subject }.to raise_error(NotImplementedError, "#{described_class.name}.call must be implemented") }
end
