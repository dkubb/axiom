require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Connective#invert' do
  before do
    @connective = ConnectiveSpecs::Object.new

    def @connective.eql?(other)
      equal?(other)
    end
  end

  subject { @connective.invert }

  it 'negates the connective' do
    should eql(Logic::Connective::Negation.new(@connective))
  end

  it 'inverts back to original' do
    subject.invert.should eql(@connective)
  end
end
