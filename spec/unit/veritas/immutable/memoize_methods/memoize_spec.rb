require 'spec_helper'
require File.expand_path('../../fixtures/classes', __FILE__)

describe 'Veritas::Immutable::MemoizeMethods#memoize' do
  subject { immutable.memoize(method, value) }

  let(:klass)     { Class.new(ImmutableSpecs::Object) }
  let(:immutable) { klass.new                         }
  let(:method)    { 'test'                            }
  let(:value)     { mock('Value')                     }

  before do
    value.should_receive(:frozen?).with(no_args).and_return(true)
    klass.memoize(method)
  end

  it { should equal(immutable) }

  it 'sets the memoized value for the method' do
    original = immutable.test
    expect { subject }.to change(immutable, :test).from(original).to(value)
  end
end
