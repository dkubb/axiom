# encoding: utf-8

require 'spec_helper'

describe Relation, '#include?' do
  subject { object.include?(tuple) }

  let(:object) { described_class.new(header, [ [ 1 ] ])        }
  let(:header) { Relation::Header.coerce([ [ :id, Integer ] ]) }

  context 'when the tuple is in the relation' do
    let(:tuple) { Tuple.new(header, [ 1 ]) }

    it { should be(true) }
  end

  context 'when the tuple is not in the relation' do
    let(:tuple) { Tuple.new(header, [ 2 ]) }

    it { should be(false) }
  end
end
