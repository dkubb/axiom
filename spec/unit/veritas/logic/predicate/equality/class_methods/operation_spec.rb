require 'spec_helper'

describe Logic::Predicate::Equality, '.operation' do
  subject { object.operation }

  let(:object) { Logic::Predicate::Equality }

  it { should be(:==) }
end
