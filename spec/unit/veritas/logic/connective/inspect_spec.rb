require 'spec_helper'

describe Logic::Connective, '#inspect' do
  subject { object.inspect }

  let(:described_class) { Class.new(Logic::Connective) }
  let(:object)          { described_class.new          }

  specify { expect { subject }.to raise_error(NotImplementedError, "#{described_class}#inspect must be implemented") }
end
