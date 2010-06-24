require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Expression#hash' do
  subject { expression.hash }

  let(:expression) { ExpressionSpecs::Object.new }

  specify { expect { subject }.to raise_error(NotImplementedError, 'ExpressionSpecs::Object#hash must be implemented') }
end
