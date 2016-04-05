require 'spectro/spec/parser'
require 'spectro/spec/rule'
require 'spectro/spec/signature'

module Spectro

  class Spec

    attr_accessor :md5, :description, :rules, :signature

    # @param [String] spec md5
    # @param [Spectro::Spec::Signature] signature spec signature
    # @param [String] description spec's description
    # @param [<Spectro::Spec::Rule>] rules collection of spec rules
    def initialize md5, signature, description, rules
      self.description = description
      self.md5 = md5
      self.rules = rules
      self.signature = signature
    end

    def == spec
      return \
        self.description == spec.description && \
        self.signature == spec.signature && \
        self.rules == spec.rules
    end

    def to_hash
      return {
        md5: self.md5,
        description: self.description,
        rules: self.rules.collect(&:to_hash),
        signature: self.signature.to_hash
      }
    end

  end

end
