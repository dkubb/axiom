require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Expression, '#inspect' do
  subject { object.inspect }

  let(:described_class) { ExpressionSpecs::Object }
  let(:object)          { described_class.new     }

  specify { expect { subject }.to raise_error(NotImplementedError, "#{described_class}#inspect must be implemented") }
end
