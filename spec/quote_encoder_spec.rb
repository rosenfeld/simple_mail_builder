# frozen_string_literal: true

require_relative '../lib/simple_mail_builder/encoder/quote'

describe SimpleMailBuilder::Encoder::Quote do
  it "doesn't encode messages that don't need to be encoded" do
    expect(SimpleMailBuilder::Encoder::Quote.encode_if_required 'Simple message!').
      to eq 'Simple message!'
  end

  it 'implements the Quoting encoding as defined in RFC2047 when required' do
    message_subject = %Q{"Quoted"/'single' 2+3:\n M&M <> (!=) ração? message_subject %&*@;$[]}
    expect(SimpleMailBuilder::Encoder::Quote.encode_if_required message_subject).
      to eq %q{=?UTF-8?Q?"Quoted"/'single'_2+3:_M&M_<>_(!=3D)_ra=C3=A7=C3=A3o=3F_message=5Fsubject_%&*@;$[]?=}
  end
end

