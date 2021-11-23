# frozen_string_literal: true

require 'json'
require_relative 'json_schema_from_hash/version'
require_relative 'json_schema_from_hash/parser'
require_relative 'json_schema_from_hash/builder'
require 'pry-byebug'
require 'active_support/core_ext/hash'

module JsonSchemaFromHash
  class Error < StandardError; end

  class << self
    def build_schema(data)
      parsed = JsonSchemaFromHash::Parser.new(data).call
      JsonSchemaFromHash::Builder.new(parsed).call
    end
  end
end
