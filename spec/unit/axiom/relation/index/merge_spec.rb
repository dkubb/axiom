# encoding: utf-8

require 'spec_helper'

describe Relation::Index, '#merge' do
  subject { object.merge(tuples) }

  let(:object) { described_class.new(key, header)                           }
  let(:key)    { Relation::Header.coerce([[:id, Integer]])                  }
  let(:header) { Relation::Header.coerce([[:id, Integer], [:name, String]]) }
  let(:tuples) { [tuple]                                                    }
  let(:tuple)  { Tuple.new(header, [1, 'John Doe'])                         }

  it_should_behave_like 'a command method'

  it 'add the tuples to the index' do
    expect { subject }.to change { object[tuple] }.from(Set[]).to(Set[tuple])
  end
end
