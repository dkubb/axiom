require 'spec_helper'

describe Attribute, '#rename' do
  subject { object.rename(name) }

  let(:klass)  { Attribute::Integer             }
  let(:object) { klass.new(:id, :size => 1..10) }

  context 'when the new name is the same' do
    let(:name) { object.name }

    it { should equal(object) }
  end

  context 'when the new name is different' do
    let(:name) { :other_id }

    it { should be_kind_of(klass) }

    it { should_not equal(object) }

    its(:name) { should equal(name) }

    its(:options) { should equal(object.options) }
  end
end
