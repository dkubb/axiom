require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

methods = [ :complement ]
methods << '!' if respond_to?('!')  # available in Ruby 1.9

methods.each do |method|
  describe "Veritas::Logic::Connective::Methods##{method}" do
    subject { proposition.send(method) }

    let(:proposition) { ConnectiveMethodsSpecs::Object.new }

    before do
      def proposition.eql?(other)
        equal?(other)
      end
    end

    it 'returns a negated proposition' do
      should eql(Logic::Connective::Negation.new(proposition))
    end
  end
end
