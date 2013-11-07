# encoding: utf-8

require 'spec_helper'

describe Tuple, '#size' do
  subject { object.size }

  let(:object) { described_class.new(header, [1])          }
  let(:header) { Relation::Header.coerce([[:id, Integer]]) }

  it_should_behave_like 'an idempotent method'

  it { should be(1) }
end
