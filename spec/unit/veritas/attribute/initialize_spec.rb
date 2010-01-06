require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#initialize' do
  before do
    @name = :id
  end

  subject { Attribute::Integer.new(@name) }

  it { should be_kind_of(Attribute) }

  it 'should set the name' do
    subject.name.should == @name
  end
end
