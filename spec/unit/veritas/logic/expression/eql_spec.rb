require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Logic::Expression, '#eql?' do
  subject { object.eql?(other) }

  let(:described_class) { ExpressionSpecs::Object }
  let(:other)           { described_class.new     }
  let(:object)          { described_class.new     }

  specify { expect { subject }.to raise_error(NotImplementedError, 'ExpressionSpecs::Object#eql? must be implemented') }
end
