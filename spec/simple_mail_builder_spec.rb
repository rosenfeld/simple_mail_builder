# frozen_string_literal: true

require_relative '../lib/simple_mail_builder'
require 'time'

describe SimpleMailBuilder do
  it 'generates a valid simple multi-part TEXT + HTML message' do
    message = SimpleMailBuilder::Message.new(to: {'João Ninguém' => 'to@d.com'},
      from: 'from@d.com', reply_to: 'reply-to@d.com',
      subject: 'Não tem coração', text: "First line\nÚltima linha",
      html: '<h1>Header</h1><p>First line</p><p>Última linha</p>').to_s
    m = message.split("\r\n")
    date = m.shift
    expect(date[0..5]).to eq 'Date: '
    date = Time.parse date.chomp("\r\n")[6..-1]
    expect(date).to be_within(5).of(Time.now) # up to 5s from now
    remaining = m.join "\r\n"
    message_id = nil
    source_to_compare = remaining.sub(/Message-ID: <(.*?)@/) do |match|
      message_id = $1
      'Message-ID: <message-id@'
    end
    expect(message_id.size).to eq 32
    expected = <<~MESSAGE_END
      From: from@d.com
      To: =?UTF-8?B?Sm/Do28gTmluZ3XDqW0=?= <to@d.com>
      Reply-to: reply-to@d.com
      Message-ID: <message-id@local.mail>
      Subject: =?UTF-8?Q?N=C3=A3o_tem_cora=C3=A7=C3=A3o?=
      Mime-Version: 1.0
      Content-Type: multipart/alternative;
       boundary="--MESSAGE BOUNDARY--";
       charset=UTF-8
      Content-Transfer-Encoding: 7bit
      
      
      ----MESSAGE BOUNDARY--
      Content-Type: text/plain; charset=UTF-8; format=flowed
      Content-Transfer-Encoding: quoted-printable
      
      First line
      =C3=9Altima linha
      
      ----MESSAGE BOUNDARY--
      Content-Type: text/html; charset=UTF-8
      Content-Transfer-Encoding: quoted-printable
      
      <h1>Header</h1><p>First line</p><p>=C3=9Altima linha</p>
      
      ----MESSAGE BOUNDARY----
    MESSAGE_END
    expect(source_to_compare).to eq expected.chomp("\n").gsub("\r", '').gsub("\n", "\r\n")
  end
end
