# frozen_string_literal: true

require 'time'
require 'digest/md5'
require_relative 'simple_mail_builder/version'
require_relative 'simple_mail_builder/encoder/quote'
require_relative 'simple_mail_builder/encoder/base64'

module SimpleMailBuilder
  class Message
    def initialize(from: , to: , subject: , text: , html: , boundary: '--MESSAGE BOUNDARY--',
                   date: Time.now, domain: 'local.mail')
      from, to = [from, to].map do |address|
        next address if String === address # otherwise we assume it's a Hash
        address.map do |name, email|
          name == email ? email : "#{Encoder::Base64.encode_or_quote(name)} <#{email}>"
        end.join ", \r\n "
      end
      text, html = [text, html].map{|s| [s].pack('M').chomp("=\n").gsub "\n", "\r\n"}
      message = []
      fdate = date.strftime '%a, %d %b %Y %H:%M:%S %z'
      message << "Date: #{fdate}"
      message << "From: #{from}"
      message << "To: #{to}"
      message_id = Digest::MD5.hexdigest [fdate, to, text, html].join
      message << "Message-ID: <#{message_id}@#{domain}>"
      message << "Subject: #{Encoder::Quote.encode_if_required subject}"
      message << 'Mime-Version: 1.0'
      message << 'Content-Type: multipart/alternative;'
      message << %Q{ boundary="#{boundary}";}
      message << ' charset=UTF-8'
      message << 'Content-Transfer-Encoding: 7bit'
      message << '' << ''
      message << "--#{boundary}"
      message << 'Content-Type: text/plain; charset=UTF-8; format=flowed'
      message << 'Content-Transfer-Encoding: quoted-printable'
      message << ''
      message << text
      message << ''
      message << "--#{boundary}"
      message << 'Content-Type: text/html; charset=UTF-8'
      message << 'Content-Transfer-Encoding: quoted-printable'
      message << ''
      message << html
      message << ''
      message << "--#{boundary}--"
      @message = message.join "\r\n"
    end

    def to_s
      @message
    end
  end
end
