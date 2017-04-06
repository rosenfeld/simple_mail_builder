# frozen_string_literal: true

require 'base64'
require_relative '../encoder'

module SimpleMailBuilder
  module Encoder
    module Base64
      def self.encode_or_quote(text)
        return %Q{"#{text.gsub '"', ''}"} unless ENCODED_REGEX =~ text
        "=?UTF-8?B?#{::Base64.strict_encode64 text}?="
      end
    end
  end
end
