require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Direction#rename' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @klass     = Class.new(Relation::Operation::Order::Direction)

    @direction = @klass.new(@attribute)
  end

  subject { @direction.rename(@aliases) }

  describe 'with aliases matching the attribute' do
    before do
      @aliases = { :id => :other_id }
    end

    it { should be_kind_of(@klass) }

    it { should eql(@klass.new(Attribute::Integer.new(:other_id))) }
  end

  describe 'with aliases not matching the attribute' do
    before do
      @aliases = { :name => :other_name }
    end

    it { should be_kind_of(@klass) }

    it { should equal(@direction) }
  end
end
