#! ruby
# -*- coding: utf-8 -*- 
require 'nokogiri'
require 'mechanize'
agent = Mechanize.new
agent.user_agent = 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.99 Safari/537.36'
page = agent.get('URL')
#agent.page.encoding = "Shift_JIS" 
#Shift_JISに変換すると送信する情報が変わってしまう
#puts page.encoding 
#puts page.body

login_form = page.forms.first
login_form.username = "username"
login_form.password = "password"
redirect_page = agent.submit(login_form)
p redirect_page.body.force_encoding("utf-8")
