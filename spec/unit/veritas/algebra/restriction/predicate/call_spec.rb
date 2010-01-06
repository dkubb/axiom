require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Predicate#call' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
    @tuple  = Tuple.new(@header, [ 1 ])

    @klass = Class.new(Algebra::Restriction::Predicate) do
      def self.name
        'AnonymousClass'
      end
    end

    # Predicate is an abstract class, so call constructor on anonymous subclass
    @predicate = @klass.new(@header[:id], 1)
  end

  subject { @predicate.call(@tuple) }

  it { method(:subject).should raise_error(NotImplementedError, 'AnonymousClass#eval must be implemented') }

  it 'should send the left and right value to #eval' do
    @response = mock('#eval response')
    @predicate.should_receive(:eval).with(1, 1).and_return(@response)
    subject.should equal(@response)
  end
end
