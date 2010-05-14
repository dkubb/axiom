require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Expression#project' do
  subject { expression.project([]) }

  let(:expression) { ExpressionSpecs::Object.new }

  it 'returns self' do
    should equal(expression)
  end
end
