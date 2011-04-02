require 'spec_helper'

describe Attribute, '#valid_value?' do
  subject { object.valid_value?(value) }

  let(:described_class) { Attribute::Integer }

  context 'when value is nil' do
    let(:value) { nil }

    context 'and the attribute is required' do
      let(:object) { described_class.new(:id) }

      it { should be(false) }
    end

    context 'and the attribute not required' do
      let(:object) { described_class.new(:id, :required => false) }

      it { should be(true) }
    end
  end

  context 'when the value is a valid primitive' do
    let(:object) { described_class.new(:id) }
    let(:value)  { 1                        }

    it { should be(true) }
  end

  context 'when the value is not a valid primitive' do
    let(:object) { described_class.new(:id) }
    let(:value)  { 'a'                      }

    it { should be(false) }
  end
end
