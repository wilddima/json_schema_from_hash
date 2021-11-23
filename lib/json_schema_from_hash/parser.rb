# frozen_string_literal: true

module JsonSchemaFromHash
  class Parser
    attr_reader :entity

    def initialize(entity)
      @entity = entity
    end

    def call
      case entity
      when Hash
        entity.each_with_object({}) do |(k, v), acc|
          acc[k.to_sym] = JsonSchemaFromHash::Parser.new(v).call
        end
      when String
        :string
      when Numeric
        :number
      when TrueClass, FalseClass
        :boolean
      when NilClass
        :null
      when Array
        entity.map { |v| JsonSchemaFromHash::Parser.new(v).call }
      else
        raise JsonSchemaFromHash::Error, "Unknown class #{entity.class}: #{entity}"
      end
    end
  end
end
