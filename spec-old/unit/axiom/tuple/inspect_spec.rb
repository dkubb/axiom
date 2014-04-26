# encoding: utf-8

require 'spec_helper'

describe Tuple, '#inspect' do
  subject { object.inspect }

  let(:header) { Relation::Header.coerce([[:id, Integer]]) }
  let(:object) { described_class.new(header, [1])          }

  it_should_behave_like 'an idempotent method'

  it { should eql({ id: 1 }.inspect) }
end
