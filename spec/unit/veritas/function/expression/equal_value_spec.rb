require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Expression, '#==' do
  subject { object == other }

  let(:described_class) { ExpressionSpecs::Object }
  let(:other)           { described_class.new     }
  let(:object)          { described_class.new     }

  specify { expect { subject }.to raise_error(NotImplementedError, 'ExpressionSpecs::Object#== must be implemented') }
end
