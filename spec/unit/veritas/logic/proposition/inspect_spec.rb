require 'spec_helper'

describe Logic::Proposition, '#inspect' do
  subject { object.inspect }

  let(:klass)  { Class.new(Logic::Proposition) }
  let(:object) { klass.new                     }

  before do
    klass.stub!(:name).and_return('Veritas::Logic::Proposition')
  end

  specify { expect { subject }.to raise_error(NotImplementedError, "#{klass.name}.call must be implemented") }
end
