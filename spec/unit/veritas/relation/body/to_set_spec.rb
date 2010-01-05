require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body#to_set' do
  before do
    header = Relation::Header.new([ [ :id, Integer ] ])
    @tuple = Tuple.new(header, [ 1 ])

    @body = Relation::Body.new(header, [ @tuple ])
  end

  subject { @body.to_set }

  it { should be_instance_of(Set) }

  it { should == Set[ @tuple ] }
end
