require 'spec_helper'

describe 'Veritas::Tuple#header' do
  subject { object.header }

  let(:klass)  { Tuple                                      }
  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:object) { klass.new(header, [ 1 ])                   }

  it_should_behave_like 'an idempotent method'

  it { should equal(header) }
end
