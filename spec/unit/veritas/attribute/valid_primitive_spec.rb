require 'spec_helper'

describe Attribute, '#valid_primitive?' do
  subject { object.valid_primitive?(value) }

  let(:klass)  { Attribute::Integer }
  let(:object) { klass.new(:id)     }

  context 'with a valid value' do
    let(:value) { 1 }

    it { should be(true) }
  end

  context 'with an invalid value' do
    let(:value) { 'a' }

    it { should be(false) }
  end
end
