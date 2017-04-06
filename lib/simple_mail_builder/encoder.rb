# frozen_string_literal: true

module SimpleMailBuilder
  module Encoder
    # a white list seems safer to me. We are allowed to encode all chars, but the purpose of
    # Q encoding is to allow us to quickly inspect its content without decoding, so we allow
    # the more common chars to skip the encoding.
    # Alternatively we could replace only =, ?, _ and tabs (and newlines/control chars?),
    # but I think a white list is simpler to implement without introducing bugs.
    ENCODED_REGEX = %r{[^a-zA-Z0-9\.\-\+/\"\'\&\(\)\<\>!:%$#@;\[\]\*\s]}
  end
end
