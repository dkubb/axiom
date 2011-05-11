require 'spec_helper'

describe Function::Connective, '#inspect' do
  subject { object.inspect }

  let(:described_class) { Class.new(Function::Connective) }
  let(:object)          { described_class.new             }

  specify { expect { subject }.to raise_error(NotImplementedError, "#{described_class}#inspect must be implemented") }
end
