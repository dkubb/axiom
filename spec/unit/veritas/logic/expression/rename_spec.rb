require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Expression#rename' do
  subject { object.rename(aliases) }

  let(:klass)   { ExpressionSpecs::Object          }
  let(:header)  { TABLE_DUM.header                 }
  let(:aliases) { Algebra::Rename::Aliases.new({}) }
  let(:object)  { klass.new                        }

  it 'returns self' do
    should equal(object)
  end
end
