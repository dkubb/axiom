Spec::Matchers.define :have_tuples_matching_predicate do
  match do |actual|
    actual.all? { |tuple| predicate.call(tuple) }
  end

  failure_message_for_should do |actual|
    "expected that #{actual.inspect} would only have tuples matching #{predicate.inspect}"
  end

  failure_message_for_should_not do |actual|
    "expected that #{actual.inspect} would not only have tuples matching #{predicate.inspect}"
  end

  description do
    "have tuples that match the predicate #{predicate.inspect}"
  end

  def predicate
    expected.first || actual.predicate
  end
end
