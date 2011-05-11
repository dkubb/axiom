require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Expression, '#rename' do
  subject { object.rename(aliases) }

  let(:described_class) { ExpressionSpecs::Object          }
  let(:header)          { TABLE_DUM.header                 }
  let(:aliases)         { Algebra::Rename::Aliases.new({}) }
  let(:object)          { described_class.new              }

  it 'returns self' do
    should equal(object)
  end
end
