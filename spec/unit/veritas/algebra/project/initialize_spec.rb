require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Project#initialize' do
  before do
    @relation = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ])
  end

  subject { Algebra::Project.new(@relation, @attributes) }

  describe 'with an Array of Attribute objects' do
    before do
      @attributes = [ Attribute.new(:id, Integer) ]
    end

    it 'should set the relation' do
      subject.relation.should equal(@relation)
    end

    it 'should set the header' do
      subject.header.should == [ [ :id, Integer ] ]
    end
  end

  describe 'with an Array of objects that respond to #to_ary' do
    before do
      @attributes = [ [ :id, Integer ] ]
    end

    it 'should set the relation' do
      subject.relation.should equal(@relation)
    end

    it 'should set the header' do
      subject.header.should == [ [ :id, Integer ] ]
    end
  end

  describe 'with an Array of objects that respond to #to_sym' do
    before do
      @attributes = [ :id ]
    end

    it 'should set the relation' do
      subject.relation.should equal(@relation)
    end

    it 'should set the header' do
      subject.header.should == [ [ :id, Integer ] ]
    end
  end

  describe 'with no attributes' do
    subject { Algebra::Project.new(@relation) }

    it 'should set the relation' do
      subject.relation.should equal(@relation)
    end

    it 'should set the header' do
      subject.header.should be_empty
    end
  end
end
