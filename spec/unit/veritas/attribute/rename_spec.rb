require 'spec_helper'

describe 'Veritas::Attribute#rename' do
  subject { attribute.rename(attribute.name => name) }

  let(:attribute) { Attribute::Integer.new(:id, :size => 1..10) }
  let(:name)      { :other_id                                   }

  it { should be_kind_of(Attribute) }

  it { should_not equal(attribute) }

  its(:name) { should equal(name) }

  its(:options) { should equal(attribute.options) }
end
