require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#initialize' do
  before do
    @name = :id
    @type = Integer
  end

  subject { Attribute.new(@name, @type) }

  it { should be_kind_of(Attribute) }

  it 'should set the name' do
    subject.name.should == @name
  end

  it 'should set the type' do
    subject.type.should == @type
  end
end
