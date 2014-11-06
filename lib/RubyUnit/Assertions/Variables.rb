require_relative 'Root'

module RubyUnit
  module Assertions
    module Variables
      include RubyUnit::AssertionMessage
      include Root

      def assertInstanceVariableDefined object, variable, message = nil
        __assert_block ASSERT_INSTANCE_VARIABLE_DEFINED_ERROR, message, {:object=>object, :variable=>variable} do
          object.instance_variables.include? variable
        end
      end

      def assertInstanceVariableNotDefined object, variable, message = nil
        __reject_block ASSERT_INSTANCE_VARIABLE_NOT_DEFINED_ERROR, message, {:object=>object, :variable=>variable} do
          object.instance_variables.include? variable
        end
      end

      def assertInstanceVariableEqual expected, object, variable, message = nil
        __assert_block ASSERT_INSTANCE_VARIABLE_EQUAL_ERROR, message, {:expected=>expected, :object=>object, :variable=>variable} do
          expected == __instance_variable(object, variable)
        end
      end

      def assertInstanceVariableNotEqual expected, object, variable, message = nil
        __assert_block ASSERT_INSTANCE_VARIABLE_NOT_EQUAL_ERROR, message, {:expected=>expected, :object=>object, :variable=>variable} do
          expected != __instance_variable(object, variable)
        end
      end

      def assertInstanceVariableKindOf klass, object, variable, message = nil
        __assert_block ASSERT_INSTANCE_VARIABLE_KIND_OF_ERROR, message, {:class=>klass, :object=>object, :variable=>variable} do
          __instance_variable(object, variable).kind_of? klass
        end
      end

      def assertInstanceVariableNotKindOf klass, object, variable, message = nil
        __reject_block ASSERT_INSTANCE_VARIABLE_NOT_KIND_OF_ERROR, message, {:class=>klass, :object=>object, :variable=>variable} do
          __instance_variable(object, variable).kind_of? klass
        end
      end

      private
      def __instance_variable object, variable
        object.instance_variable_get "@#{variable}".to_sym
      end
    end
  end
end
