# coding: utf-8

# -*- encoding: utf-8 -*-
require 'mail'
require 'erb'

class Reporter

  def self.report(division_name, results)

    options = { 
      :address              => "smtp.gmail.com",
      :port                 => 587,
      :user_name            => 'ymt07066111514@gmail.com',
      :password             => '******',
      :authentication       => 'plain',
      :enable_starttls_auto => true  
    }

    Mail.defaults do
      delivery_method :smtp, options
    end

    contents = <<-EOS
分譲地：<%= division_name %>
<% results.each do |result| %>
  <%= result.to_s %>
<% end %>
EOS

    mail = Mail.new do
      from     'ymt07066111514@gmail.com'
      to       'iino.tat@yamat.co.jp'
      subject  "ソーラー君監視システム　#{Time.now.strftime('%Y/%m/%d %H時台')}"
      body     ERB.new(contents).result(binding)
    end

    mail.deliver!

  end
end
