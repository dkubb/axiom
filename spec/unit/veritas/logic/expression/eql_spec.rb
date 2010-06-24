require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Expression#eql?' do
  subject { expression.eql?(other) }

  let(:other)      { ExpressionSpecs::Object.new }
  let(:expression) { ExpressionSpecs::Object.new }

  specify { expect { subject }.to raise_error(NotImplementedError, 'ExpressionSpecs::Object#eql? must be implemented') }
end
