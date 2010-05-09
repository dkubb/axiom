require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Connective#complement' do
  subject { connective.complement }

  let(:connective) { ConnectiveSpecs::Object.new }

  before do
    def connective.eql?(other)
      equal?(other)
    end
  end

  it 'negates the connective' do
    should eql(Logic::Connective::Negation.new(connective))
  end

  it 'is reversible' do
    subject.complement.should eql(connective)
  end
end
