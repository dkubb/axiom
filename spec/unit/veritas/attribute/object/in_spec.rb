require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Object#in' do
  before do
    @attribute = Attribute::Object.new(:data)
  end

  subject { @attribute.in([ { :active => true }, { :active => false } ]) }

  it { should be_kind_of(Algebra::Restriction::Inclusion) }
end
