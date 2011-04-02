require 'spec_helper'

describe Logic::Connective, '#inspect' do
  subject { object.inspect }

  let(:klass)  { Class.new(Logic::Connective) }
  let(:object) { klass.new                    }

  specify { expect { subject }.to raise_error(NotImplementedError, "#{klass}#inspect must be implemented") }
end
