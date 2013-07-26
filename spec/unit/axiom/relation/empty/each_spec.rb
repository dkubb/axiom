# encoding: utf-8

require 'spec_helper'

describe Relation::Empty, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:object) { described_class.new(header) }
  let(:header) { [[:id, Integer]]            }
  let(:yields) { []                          }

  it_should_behave_like 'an #each method'

  it 'yields no tuples' do
    subject
    yields.should be_empty
  end
end
