# frozen_string_literal: true

require_relative '../lib/simple_mail_builder/encoder/base64'

describe SimpleMailBuilder::Encoder::Base64 do
  it 'only strips " and quotes when no encoding is required' do
    expect(SimpleMailBuilder::Encoder::Base64.encode_or_quote 'Rodrigo "Rosenfeld" Rosas').
      to eq '"Rodrigo Rosenfeld Rosas"'
  end

  it 'applies base64 encoding for special chars' do
    expect(SimpleMailBuilder::Encoder::Base64.encode_or_quote "João Ninguém").
      to eq "=?UTF-8?B?Sm/Do28gTmluZ3XDqW0=?="
  end
end

