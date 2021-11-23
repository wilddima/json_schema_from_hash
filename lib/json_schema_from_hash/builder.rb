# frozen_string_literal: true

module JsonSchemaFromHash
  class Builder
    SYMBOLS_JSON = {
      string: { type: :string },
      boolean: { type: :boolean },
      number: { type: :number },
      null: { type: :null }
    }.freeze

    attr_reader :entity

    def initialize(entity)
      @entity = entity
    end

    def call
      case entity
      when Hash
        parse_hash(entity)
      when Array
        parse_array(entity)
      when Symbol
        parse_symbol(entity)
      else
        raise JsonSchemaFromHash::Error, "Unknown class #{entity.class}: #{entity}"
      end
    end

    private

    def parse_hash(hash)
      data = { type: :object }
      data[:properties] = hash.each_with_object({}) do |(k, v), acc|
        acc[k.to_sym] = JsonSchemaFromHash::Builder.new(v).call
      end
      data
    end

    def parse_array(array)
      items = array.map { |v| JsonSchemaFromHash::Builder.new(v).call }.uniq
      items = { oneOf: items } if items.size > 1
      { type: :array, items: items }
    end

    def parse_symbol(symbol)
      SYMBOLS_JSON[symbol]
    end
  end
end
