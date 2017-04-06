# frozen_string_literal: true

require_relative '../encoder'

# See RFC2047 to fully understand how "B" and "Q" encondings work.
# Basically only ASCII chars are allowed to go unencoded, although they may be encoded.
# Exceptions are espaces (' '), which can be encoded as underscore ('_') alternatively to
# the default encoding system described below, and the following chars that must be encoded:
# '=', '?', '_' and tabs. Encoded chars are represented as '=XX' where XX is the hexadecimal
# representation in the message charset with 2 digits.
module SimpleMailBuilder
  module Encoder
    module Quote
      def self.encode_if_required(text)
        return text unless ENCODED_REGEX =~ text
        text = text.gsub(ENCODED_REGEX){ |c| c.bytes.map{|b| '=%02X' % b }.join }.gsub /\s+/, '_'
        "=?UTF-8?Q?#{text}?="
      end
    end
  end
end
