# encoding: utf-8

require 'spec_helper'

describe Relation::Index, '#<<' do
  subject { object << tuple }

  let(:object) { described_class.new(key, header.project(name_only))        }
  let(:key)    { Relation::Header.coerce([[:id, Integer]])                  }
  let(:header) { Relation::Header.coerce([[:id, Integer], [:name, String]]) }
  let(:tuple)  { Tuple.new(header, [1, 'John Doe'])                         }

  let(:name_only) do
    header.project([:name])
  end

  it_should_behave_like 'a command method'

  it 'adds the tuple to the index' do
    expect { subject }.to change { object[tuple] }
      .from(Set[]).to(Set[tuple.project(name_only)])
  end
end
