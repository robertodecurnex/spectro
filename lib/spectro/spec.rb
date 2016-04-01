require 'spectro/spec/parser'
require 'spectro/spec/rule'
require 'spectro/spec/signature'

module Spectro

  class Spec

    attr_accessor :md5, :rules, :signature

    # @param [String] spec md5
    # @param [Spectro::Spec::Signature] signature spec signature
    # @param [<Spectro::Spec::Rule>] rules collection of spec rules
    def initialize md5, signature, rules
      self.md5 = md5
      self.rules = rules
      self.signature = signature
    end

    def == spec
      return \
        self.signature == spec.signature && \
        self.rules == spec.rules
    end

    def to_json options = nil
      return {
        md5: self.md5,
        rules: self.rules.to_json(options),
        signature: self.signature.to_json(options)
      }.to_json(options)
    end

  end

end
