# encoding: utf-8

require 'spec_helper'

describe Tuple, '#to_ary' do
  subject { object.to_ary }

  let(:object) { described_class.new(header, body)         }
  let(:header) { Relation::Header.coerce([[:id, Integer]]) }
  let(:body)   { [1]                                       }

  context 'when the body is frozen' do
    let(:body) { super().freeze }

    it_should_behave_like 'an idempotent method'

    it { should be_instance_of(Array) }

    it { should be_frozen }

    it { should be(body) }
  end

  context 'when the body is frozen' do
    it_should_behave_like 'an idempotent method'

    it { should be_instance_of(Array) }

    it { should be_frozen }

    it { should_not be(body) }

    it { should eql(body) }
  end
end
