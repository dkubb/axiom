require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Object#ne' do
  before do
    @attribute = Attribute::Object.new(:data)
  end

  subject { @attribute.ne(:active => true) }

  it { should be_kind_of(Algebra::Restriction::Inequality) }
end
