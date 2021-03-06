require 'RubyUnit/SkippedTest'

module SkippedTestTests
  #
  # Test Case for RubyUnit::SkippedTest
  #
  class TC_SkippedTest < RubyUnit::TestCase
    #
    # Validate that RubyUnit::SkippedTest is an Exception
    #
    def isExceptionTest
      assertDescendent Exception, RubyUnit::SkippedTest, 'SkippedTest MUST be an Exception!'
    end
  end
end
