module RubyUnit
  #
  # Assertions that can be used by RubyUnit::TestCase
  #
  module Assertions
    # Tracks the total number of assertions made during the tests
    @@assertions = 0

    #
    # Fail the test. This is used when some conditioned outside the test warrants
    # a test failure.
    # * This is likely an indication of something unexpected or missing functionality
    # * raises RubyUnit::AssertionFailure
    #
    # message::
    #   The message provided to be reported for a failure
    #
    # data::
    #   The data associated with assertion
    #
    #  fail "I wasn't expecting the moon to fall into Lake Michigan"  # => fail
    #
    def fail message = nil, data = {}
      __wrap_assertion do
        build_message AssertionFailure::FAILING, message, data
      end
    end

    #
    # Assert that a test condition is true.
    # * raises RubyUnit::AssertionFailure if _value_ is false or nil
    #
    # value::
    #   The value that is being checked by the assertion
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assert false, "This will fail"  # => fail
    #
    def assert value, message = nil
      __assert value, AssertionFailure::ASSERT_ERROR, message, {:value=>value}
    end

    #
    # Assert that a test condition is false.
    # * raises RubyUnit::AssertionFailure unless _value_ is false or nil
    #
    # value::
    #   The value that is being checked by the assertion
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertNot true, "This will fail"  # => fail
    #
    def assertNot value, message = nil
      __reject value, AssertionFailure::ASSERT_NOT_ERROR, message, {:value=>value}
    end

    #
    # Assert that a test condition is exactly true.
    # * raises RubyUnit::AssertionFailure unless _value_ is true
    #
    # value::
    #   The value that is being checked by the assertion
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertTrue false, "This will fail"  # => fail
    #
    def assertTrue value, message = nil
      __assert (true == value), AssertionFailure::ASSERT_TRUE_ERROR, message, {:value=>value}
    end

    #
    # Assert that a test condition is exactly false.
    # * raises RubyUnit::AssertionFailure unless _value_ is false
    #
    # value::
    #   The value that is being checked by the assertion
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertNil true, "This will fail"  # => fail
    #
    def assertFalse value, message = nil
      __assert (false == value), 'Failed to assert that value is EXACTLY false', message, {:value=>value}
    end

    #
    # Assert that a test condition is exactly nil.
    # * raises RubyUnit::AssertionFailure unless _value_ is nil
    #
    # value::
    #   The value that is being checked by the assertion
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertNil true, "This will fail"  # => fail
    #
    def assertNil value, message = nil
      __assert value.nil?, 'Failed to assert that value is EXACTLY nil', message, {:value=>value}
    end

    #
    # Assert that a test condition is not nil.
    # * raises RubyUnit::AssertionFailure if _value_ is nil
    #
    # value::
    #   The value that is being checked by the assertion
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertNotNil nil, "This will fail"  # => fail
    #
    def assertNotNil value, message = nil
      __reject value.nil?, 'Failed to assert that value is NOT nil', message, {:value=>value}
    end

    #
    # Assert that two values are equal.
    # * raises RubyUnit::AssertionFailure unless _expected_ equals _actual_
    #
    # expected::
    #   The value that is forbidden by the assertion
    #
    # actual::
    #   The value that is being checked by the assertion
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertEqual 42, 24, "This will fail"  # => fail
    #
    def assertEqual expected, actual, message = nil
      __assert (expected == actual), 'Failed to assert that values are equal', message, {:expected=>expected, :actual=>actual}
    end

    #
    # Assert that two values are NOT equal.
    # * raises RubyUnit::AssertionFailure if _illegal_ equals _actual_
    #
    # illegal::
    #   The value that is not allowed by the assertion
    #
    # actual::
    #   The value that is being checked by the assertion
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertNotEqual 3.14, 3.14, "This will fail"  # => fail
    #
    def assertNotEqual illegal, actual, message = nil
      __reject (illegal == actual), 'Values should NOT be equal', message, {:illegal=>illegal, :actual=>actual} 
    end

    #
    # Assert that one value is greater than another.
    # * raises RubyUnit::AssertionFailure unless _greater_ is greater than _value_
    #
    # greater::
    #   The value that should be greater
    #
    # value::
    #   The value that is being checked by the assertion
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertGreaterThan 24, 42, "This will fail"  # => fail
    #
    def assertGreaterThan greater, value, message = nil
      __assert (greater > value), 'Failed to assert that value is greater than', message, {:greater=>greater, :value=>value}
    end

    #
    # Assert that one value is greater than another.
    # * raises RubyUnit::AssertionFailure unless _greater_ is greater than or equal to _value_
    #
    # greater::
    #   The value that should be greater than or equal
    #
    # value::
    #   The value that is being checked by the assertion
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertGreaterThanOrEqual 24, 42, "This will fail"  # => fail
    #
    def assertGreaterThanOrEqual greater, value, message = nil
      __assert (greater >= value), 'Failed to assert that value is greater than or equal', message, {:greater=>greater, :value=>value}
    end

    #
    # Assert that one value is less than another.
    # * raises RubyUnit::AssertionFailure unless _less_ is less than _value_
    #
    # less::
    #   The value that should be less
    #
    # value::
    #   The value that is being checked by the assertion
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertLessThan 42, 24, "This will fail"  # => fail
    #
    def assertLessThan less, value, message = nil
      __assert (less < value), 'Failed to assert that value is less than', message, {:less=>less, :value=>value}
    end

    #
    # Assert that one value is less than another.
    # * raises RubyUnit::AssertionFailure unless _less_ is less than or equal to _value_
    #
    # less::
    #   The value that should be less than or equal
    #
    # value::
    #   The value that is being checked by the assertion
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertLessThanOrEqual 42, 24, "This will fail"  # => fail
    #
    def assertLessThanOrEqual less, value, message = nil
      __assert (less <= value), 'Failed to assert that value is less than or equal', message, {:less=>less, :value=>value}
    end

    #
    # Assert that a value matches a Regexp pattern.
    # * raises RubyUnit::AssertionFailure unless _value_ matches _pattern_
    #
    # pattern::
    #   A Regexp pattern expected by the assertion
    #
    # value::
    #   The value that is being checked for the assertion
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertMatch /^Hello/, 'Goodbye!', "This will fail"  # => fail
    #
    def assertMatch pattern, value, message = nil
        __assert (value =~ pattern), 'Failed to assert value matches pattern', message, {:pattern=>pattern, :value=>value}
    end

    #
    # Assert that a value does not match a Regexp pattern.
    # * raises RubyUnit::AssertionFailure if _value_ matches _pattern_
    #
    # pattern::
    #   A Regexp pattern excluded by the assertion
    #
    # value::
    #   The value that is being checked for the assertion
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertMatch /^Good/, 'Goodbye!', "This will fail"  # => fail
    #
    def assertNotMatch exclusion, value, message = nil
      __reject (value =~ exclusion), 'Value should NOT match exclusion', message, {:exclusion=>exclusion, :value=>value}
    end

    #
    # Assert that two objects are the same object
    # * raises RubyUnit::AssertionFailure unless _expected_ and _actual_ are
    #   the same object.
    #
    # expected::
    #   The expected object
    #
    # actual::
    #   The object that is being checked against _expected_
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertSame '42', 42, 'Not even close.'  # => fail
    #
    def assertSame expected, actual, message = nil
      __assert (expected.equal? actual), 'Failed to assert objects are the same', message, {:expected=>expected, :actual=>actual}
    end

    #
    # Assert that two objects are not the same object
    # * raises RubyUnit::AssertionFailure if _illegal_ and _actual_ are the
    #   same object.
    #
    # illegal::
    #   The expected that it shouldn't be
    #
    # actual::
    #   The object that is being checked against _illegal_
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertNotSame value, value, 'Imagine that!'  # => fail
    #
    def assertNotSame illegal, actual, message = nil
      __reject (illegal.equal? actual), 'Objects shoul NOT be the same', message, {:illegal=>illegal, :actual=>actual}
    end

    #
    # Assert that an object is an instance of the specified class or one of
    # its descendents.
    # * raises RubyUnit::AssertionFailure unless _object_ is an instance of
    #   _klass_ or one of its descendents. 
    #
    # klass::
    #   The class that is expected
    #
    # object::
    #   The object that will be checked against _klass_
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertKindOf String, 25, 'Nope, try again.'  # => fail
    #
    def assertKindOf klass, object, message = nil
      __assert (object.is_a? klass), 'Failed to assert object heritage', message, {:klass=>klass, :object=>object}
    end
    
    alias_method :assertIsA, :assertKindOf

    #
    # Assert that an object is not an instance of the specified class or one of
    # its descendents.
    # * raises RubyUnit::AssertionFailure if _object_ is an instance of _exclusion_ or
    # one of its descendents. 
    #
    # exclusion::
    #   The class that is excluded
    #
    # object::
    #   The object that will be checked against _klass_
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertNotKindOf Numeric, 25, 'Nope, try again.'  # => fail
    #
    def assertNotKindOf exclusion, object, message = nil
      __reject (object.is_a? exclusion), 'Object should NOT be a descendent', message, {:exclusion=>exclusion, :object=>object}
    end

    [:assertNotIsA, :assertIsNotA].each do |method|
      alias_method method, :assertNotKindOf
    end

    #
    # Assert that an object is an instance of a specified class
    # * raises RubyUnit::AssertionFailure unless _object_ is an instance of _klass_.
    #
    # klass::
    #   The class that is expected
    #
    # object::
    #   The object that will be checked against _klass_
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertInstanceOf Integer, '25', 'So close, but... No.'  # => fail
    #
    def assertInstanceOf klass, object, message = nil
      __assert (object.instance_of? klass), 'Failed to assert object instance', message, {:klass=>klass, :object=>object}
    end

    #
    # Assert that an object is an instance of a specified class
    # * raises RubyUnit::AssertionFailure unless _object_ is an instance of _klass_.
    #
    # exclusion::
    #   The class that is expected
    #
    # object::
    #   The object that will be checked against _klass_
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertNotInstanceOf Integer, 25, 'So close, but... No.'  # => fail
    #
    def assertNotInstanceOf exclusion, object, message = nil
      __reject (object.instance_of? exclusion), 'Object should NOT be this instance', message, {:exclusion=>exclusion, :object=>object}
    end

    #
    # Assert that a collection includes a specified value
    # * raises RubyUnit::AssertionFailure unless _collection_ responds to _value_
    #
    # object::
    #   The collection to check
    #
    # method::
    #   The value the object should contain
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertInclude [1, 2], 'not in', 'It does not, so... no'  # => fail
    #
    def assertInclude collection, value, message = nil
      assertRespondTo collection, :include?, message
      __assert (collection.include? value), 'Failed to assert collection includes value', message, {:collection=>collection, :value=>value}
    end

    #
    # Assert that a collection does not include a specified value
    # * raises RubyUnit::AssertionFailure if _collection_ responds to _value_
    #
    # object::
    #   The collection to check
    #
    # method::
    #   The value the object should not contain
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertNotInclude [1, 2, 3], 2, 'It does, so close'  # => fail
    #
    def assertNotInclude collection, value, message = nil
      assertRespondTo collection, :include?, message
      __reject (collection.include? value), 'Collection should NOT include value', message, {:collection=>collection, :value=>value}
    end

    #
    # Assert that a value is empty
    # * raises RubyUnit::AssertionFailure unless _object_ responds to :empty?
    # * raises RubyUnit::AssertionFailure unless _object_ is empty
    #
    # object::
    #   The object to check
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertEmpty [1, 2], 'Not empty'  # => fail
    #
    def assertEmpty object, message = nil
      assertRespondTo object, :include?, message
      __assert object.empty?, 'Failed to assert object is empty', message, {:object=>object}
    end

    #
    # Assert that a value is not empty
    # * raises RubyUnit::AssertionFailure unless _object_ responds to :empty?
    # * raises RubyUnit::AssertionFailure if _object_ is empty
    #
    # object::
    #   The object to check
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertNotInclude [1, 2, 3], 2, 'It does, so close'  # => fail
    #
    def assertNotEmpty object, message = nil
      assertRespondTo object, :include?, message
      __reject object.empty?, 'Failed to assert object is NOT empty', message, {:object=>object}
    end

    #
    # Assert that a class is a descendent of another class
    # * raises RubyUnit::AssertionFailure unless _descendent_ is a descendent of _klass_
    #
    # klass::
    #   The parent class
    #
    # descendent::
    #   The descendent class
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertDescendent Numeric, Exception, 'Nope'  # => fail
    #
    def assertDescendent klass, descendent, message = nil
      __assert (descendent < klass), 'Failed to assert class heritage', message, {:klass=>klass, :descendent=>descendent}
    end

    #
    # Assert that a class is not a descendent of another class
    # * raises RubyUnit::AssertionFailure if _illegal_ is a descendent of _klass_
    #
    # klass::
    #   The parent class
    #
    # descendent::
    #   The illegal descendent class
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertDescendent StandardError, Exception, 'It is'  # => fail
    #
    def assertNotDescendent klass, illegal, message = nil
      __reject (descendent < klass), 'Class should NOT be a descendent', message, {:klass=>klass, :descendent=>descendent}
    end

    #
    # Assert that a constant is defined correctly in the correct class
    # * raises RubyUnit::AssertionFailure unless the constant is defined in
    #   the specified class and it is the correct type and value
    #
    # expected::
    #   The value that is expected for the constant
    #
    # klass::
    #   The class where the constant should be defined
    #
    # konstant::
    #   The name of the constant
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertConst 42, Numbers, 'TWENTYFOUR', 'So dyslexic.'  # => fail
    #
    def assertConst expected, klass, konstant, message = nil
      __wrap_assertion do
        assertConstDefined klass, konstant, message
        value = klass.const_get konstant
        assertIsA expected.class, value, message
        assertEqual expected, value, message
      end
    end

    #
    # Assert that a constant is defined in the specified class
    # * raises RubyUnit::AssertionFailure unless the constant is defined in
    #   the specified class
    #
    # klass::
    #   The class where the constant should be defined
    #
    # konstant::
    #   The name of the constant
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertConstDefined Numbers, 'FORTYTWO', 'Mystery.'  # => ??
    #
    def assertConstDefined klass, konstant, message = nil
      __assert (klass.const_defined? konstant), 'Failed to assert constant is defined', message, {:klass=>klass, :konstant=>konstant}
    end

    #
    # Assert that a constant is not defined in the specified class
    # * raises RubyUnit::AssertionFailure if the constant is defined in
    #   the specified class
    #
    # klass::
    #   The class where the constant should not be defined
    #
    # konstant::
    #   The name of the constant
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertConstNotDefined Numbers, 'TWENTYFOUR', 'Mystery.'  # => ??
    #
    def assertConstNotDefined klass, konstant, message = nil
      __reject (klass.const_defined? konstant), 'Constant should not be defined', message, {:klass=>klass, :konstant=>konstant}
    end

    #
    # Assert that no exception is raised.
    # * raises RubyUnit::AssertionFailure if any exception is raised
    #
    # message::
    #   The message provided to be reported for a failure
    #
    # &block::
    #   The code block that is executed
    #
    #  assertNothingRaised 'Not expecting an exception!' do
    #    # do something
    #  end
    #
    def assertNothingRaised message = nil, &block
      __wrap_assertion do
        begin
          yield
        rescue Exception => e
          build_message 'Exception should NOT be raised', message, {:exception=>e.message}
        end
      end
    end

    #
    # Assert that a specified exception message is raised.
    # * raises RubyUnit::AssertionFailure unless the correct Exception message is raised
    #
    # pattern::
    #   The String or Regexp that will be used to validate the Exception message
    #
    # message::
    #   The message provided to be reported for a failure
    #
    # &block::
    #   The code block that is expected to throw the Exception
    #
    #  assertRaiseMessage /^Invalid/, 'Expecting an exception!' do
    #    # do something
    #  end
    #
    def assertRaiseMessage pattern, message = nil, &block
      assertRaiseExpected Exception, pattern, message, &block
    end

    #
    # Assert that a specified exception type is raised.
    # * raises RubyUnit::AssertionFailure unless the correct Exception type is raised
    #
    # e::
    #   The Exception class that is expected.
    #
    # message::
    #   The message provided to be reported for a failure
    #
    # &block::
    #   The code block that is expected to throw the Exception
    #
    #  assertRaiseKindOf StandardError, 'Expecting an exception!' do # => fail
    #    # do something
    #  end
    #
    def assertRaiseKindOf e, message = nil, &block
      assertRaiseExpected e, '', message, &block
    end

    #
    # Assert that a specified exception is raised.
    # * raises RubyUnit::AssertionFailure unless the correct Exception is raised
    #
    # exception::
    #   The Exception class that is expected.
    #
    # pattern::
    #   The String or Regexp that will be used to validate the Exception message
    #
    # message::
    #   The message provided to be reported for a failure
    #
    # &block::
    #   The code block that is expected to throw the Exception
    #
    #  assertRaiseExpected StandardError, /^Invalid/, 'Expecting an exception!' do
    #    raise StandardError, 'Invalid Retroincabulator'
    #  end
    #
    def assertRaiseExpected exception, pattern, message = nil, &block
      __validate_exception pattern, exception
      __wrap_assertion do
        begin
          yield
          build_message 'Expected exception was not raised', message, {:exception=>exception, :pattern=>pattern}
        rescue exception => e
          assertEqual pattern, e.message if pattern.is_a? String and pattern.length > 0
          assertMatch pattern, e.message if pattern.is_a? Regexp
          e
        end
      end
    end

    #
    # Assert that an object responds to particular method
    # * raises RubyUnit::AssertionFailure unless _object_ responds to _method_
    #
    # object::
    #   The object to check
    #
    # method::
    #   The method to assert on the object
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertRespondTo /^Regexp/, :length, 'It does not, so... no'  # => fail
    #
    def assertRespondTo object, method, message = nil
      __assert (object.respond_to? method), 'Failed to assert object responds to method', message, {:object=>object, :method=>method}
    end

    #
    # Assert that an object does not respond to a particular method
    # * raises RubyUnit::AssertionFailure if _object_ responds to _method_
    #
    # object::
    #   The object to check
    #
    # method::
    #   The method to assert on the object
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertNotRespondTo 25, :integer?, 'It does, so close'  # => fail
    #
    def assertNotRespondTo object, method, message = nil
      __assert (object.respond_to? method), 'Object should NOT respond to method', message, {:object=>object, :method=>method}
    end

    #
    # Assert that an object has defined the specified method.
    # * raises RubyUnit::AssertionFailure unless _klass_ has defined _method_
    #
    # klass::
    #   The object to check for _method_
    #
    # method::
    #   The method to check
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertMethod String, :integer?, 'Nope' # => fail
    #
    def assertMethod klass, method, message = nil
      assertInclude klass.methods, method, message
    end

    #
    # Assert that an object has not defined the specified method.
    # * raises RubyUnit::AssertionFailure if _klass_ has defined _method_
    #
    # klass::
    #   The object to check for _method_
    #
    # method::
    #   The method to check
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertNotMethod Integer, :integer?, 'Nope' # => fail
    #
    def assertNotMethod klass, not_method, message = nil
      assertNotInclude klass.methods, not_method, message
    end

    #
    # Assert that an object has defined the specified instance method.
    # * raises RubyUnit::AssertionFailure unless _klass_ has defined _instance_method_
    #
    # klass::
    #   The object to check for _instance_method_
    #
    # method::
    #   The method to check
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertInstanceMethod String, :integer?, 'Nope' # => fail
    #
    def assertInstanceMethod klass, instance_method, message = nil
      assertInclude klass.instance_methods, instance_method, message
    end

    #
    # Assert that an object has not defined the specified instance method.
    # * raises RubyUnit::AssertionFailure unless _klass_ has defined _not_instance_method_
    #
    # klass::
    #   The object to check for _not_instance_method_
    #
    # method::
    #   The method to check
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertNotInstanceMethod Integer, :integer?, 'Nope' # => fail
    #
    def assertNotInstanceMethod klass, not_instance_method, message = nil
      assertNotInclude klass.instance_methods, not_instance_method, message
    end

    #
    # Assert that an Class has defined the specified class method.
    # * raises RubyUnit::AssertionFailure unless _klass_ has defined _class_method_
    #
    # klass::
    #   The object to check for _class_method_
    #
    # method::
    #   The method to check
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertClassMethod String, :integer?, 'Nope' # => fail
    #
    def assertClassMethod klass, class_method, message = nil
      assertInclude klass.singleton_methods, class_method, message
    end

    #
    # Assert that an Class has not defined the specified class method.
    # * raises RubyUnit::AssertionFailure unless _klass_ has defined _not_class_method_
    #
    # klass::
    #   The object to check for _not_class_method_
    #
    # method::
    #   The method to check
    #
    # message::
    #   The message provided to be reported for a failure
    #
    #  assertNotClassMethod String, :new, 'Nope' # => fail
    #
    def assertNotClassMethod klass, not_class_method, message = nil
      assertNotInclude klass.singleton_methods, not_class_method, message
    end

    private
    #
    # Builds the message that will be used with the assertion
    # * raises RubyUnit::AssertionFailure
    # * raises ArgumentError unless error is a String
    # * raises ArgumentError unless message is nil or a String
    # * raises ArgumentError unless data is a Hash
    #
    # error::
    #   The assertion description
    #
    # message::
    #   The message provided by the test for the assertion
    #
    # data::
    #   The data associated with assertion failure
    #
    #  build_message 'Failing Test', message, {'expected' => expected, 'actual' => actual }
    #
    def build_message error, message, data = {} # :nodoc:
      raise ArgumentError, 'Error description must be a String' unless error.is_a? String
      raise ArgumentError, 'Failure message must be String' unless message.nil? or message.is_a? String
      raise ArgumentError, 'Failure data must be a Hash' unless data.is_a? Hash
      raise AssertionFailure.new({'Assertion Failure'=>message}.merge data), error
    end

    #
    # The assertion wrapper is responsible for doing everything that must be done
    # on each assertion.
    # * keep track of the total number of assertions
    #
    # &block::
    #   The assertion which is being wrapped
    #
    def __wrap_assertion &block # :nodoc:
      @@assertions += 1
      yield
    end

    #
    # Internally validate that an assertion not false or nil
    # * raises RubyUnit::AssertionFailure unless _value_ is true 
    #
    # value::
    #   The value to be asserted
    #
    # error::
    #   The error associated with the assertion being checked
    #
    # message::
    #   The message provided to be reported for a failure
    #
    # data::
    #   The data associated with assertion
    #
    #  __assert value, 'Failed to assert value is true', message, {:value=>value}
    #
    def __assert value, error, message, data # :nodoc:
      __wrap_assertion do
        build_message error, message, data unless value
      end
    end

    #
    # Internally validate that an assertion is false or nil
    # * raises RubyUnit::AssertionFailure unless _value_ is false or nil 
    #
    # value::
    #   The value to be asserted
    #
    # error::
    #   The error associated with the assertion being checked
    #
    # message::
    #   The message provided to be reported for a failure
    #
    # data::
    #   The data associated with assertion
    #
    #  __reject value, 'Failed to assert value is not true', message, {:value=>value}
    #
    def __reject value, error, message, data # :nodoc:
      __assert (not value), error, message, data
    end

    #
    # Validate the parameters for exception assertions
    # * raises ArgumentError if _pattern_ is not a String or Regexp
    # * raises ArgumentError unless _e_ is a descendent of the Exception class
    #
    def __validate_exception pattern, e = Exception # :nodoc:
      raise ArgumentError, "Exception message must be a Regexp or String" unless pattern.is_a? Regexp or pattern.is_a? String
      raise ArgumentError, "Exception must be a subclass of Exception" unless e < Exception
    end
  end
end
