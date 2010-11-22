require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Expression#eql?' do
  subject { object.eql?(other) }

  let(:klass)  { ExpressionSpecs::Object }
  let(:other)  { klass.new               }
  let(:object) { klass.new               }

  specify { expect { subject }.to raise_error(NotImplementedError, 'ExpressionSpecs::Object#eql? must be implemented') }
end
