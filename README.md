# SimpleMailBuilder

SimpleMailBuilder makes it easier to create simple multi-part plain text + HTML mail messages,
following the most important rules from RFC2047 and RFC2045. Simple messages have the following
headers: To, From and Subject. They have a text part, an HTML part and no attachments.

For a more complete full-specs implementation use the well known "mail" gem.
I created this gem because the "mail" gem will patch core classes (String mostly) and I wanted
to avoid monkey patches in my application. Also, it adds quite some overhead and I find its code
base is a bit complicated to understand and wanted to rely on something simpler to reason about.

My application doesn't need to do anything complex with e-mails. It just has to deliver a
simple multi-part text + HTML message with no attachments to an SMTP server and it doesn't have
to handle edge cases, like handling chars limits in headers and so on. If you don't have
much control over your messages, it's better to use another library for creating mail messages.

All messages are creating using the UTF-8 charset to make the code simpler. All inputs are
expected to be in UTF-8 encoding already, so if you are reading the content from some file in
another encoding you should make sure you convert to UTF-8 before using this library.

It uses a static '--MESSAGE BOUNDARY--' as the boundary by default, so if your messages could
contain such text embedded you should take care of providing a valid boundary yourself as
this library won't handle such edge cases.

From and To addresses should be either a plain single e-mail or a Hash mapping e-mails to the
names ({'User Name' => 'user@name.com'}). You may use the e-mail as the key too
when you don't have a corresponding name and in that case the name would be ignored when
generating the headers and just the e-mail would be used.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_mail_builder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_mail_builder

## Usage

```ruby
    require 'net/smtp'
    require 'simple_mail_builder'
    message = SimpleMailBuilder::Message.new(
      to: {'Recipient' => 'to@domain.com'},
      from: 'from@domain.com', subject: 'Message subject',
      text: "Header\n\nFirst line\nLast line",
      html: '<h1>Header</h1><p>First line</p><p>Last line</p>'
    ).to_s
    Net::SMTP.start('localhost', 1025) do |smtp|
      smtp.send_message message, 'from@domain.com', 'to@domain.com'
    end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to
run the tests. You can also run `bin/console` for an interactive prompt that will allow you to
experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new
version, update the version number in `version.rb`, and then run `bundle exec rake release`,
which will create a git tag for the version, push git commits and tags, and push the `.gem`
file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on the
[GitHub repo](https://github.com/rosenfeld/simple_mail_builder).


## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

