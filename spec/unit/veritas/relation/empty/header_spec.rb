require 'spec_helper'

describe 'Veritas::Relation::Empty#header' do
  subject { object.header }

  let(:klass)  { Relation::Empty                            }
  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:object) { klass.new(header)                          }

  it_should_behave_like 'an idempotent method'

  it { should equal(header) }
end
