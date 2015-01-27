# -*- coding: utf-8 -*- 
require 'nokogiri'
# HTMLページのロード ############################
#

# 文字列の場合
html ="<html>...</html>"
doc = Nokogiri::HTML(html)

# fileの場合
File.open("test.html") do |f|
  doc = Nokogiri::HTML(f)
end

# webページの場合 open-uri利用
require 'open-uri'
doc = Nokogiri::HTML(open('http://mukaer.com'))

# xml
doc = Nokogiri::XML(open('http://mukaer.com/atom.xml'))


# 要素の検索 ####################################
#
# Xpath or CSS3 の記述指定が可能

# xpath
doc.xpath("//div")

# css
doc.css("div")
doc.css("#header")
doc.css("div > h1")

# 両方
doc.search("//div" ,"div#footer")


# １つの要素を取得 ################################
#

doc.css("#header").first
doc.at_css("#header")

# last
doc.css("#header").last


# 要素の情報取得 ################################
#

# to_html
doc.css("div").each do |elm|
  p elm.to_html
end
   #=> "<div id=\"header\"><h1>title</h1></div>"
   #=> "<div id=\"content\"><h2>content tiltel</h2></div>"
   #=> "<div id=\"footer\">cont end</div>"

# inner_html
doc.css("div").each do |elm|
  p elm.inner_html
end
   #=> "<h1>title</h1>"
   #=> "<h2>content tiltel</h2>"
   #=> "cont end"

# content inner_text
doc.css("div").each do |elm|
  p elm.content
end
   #=> "title"
   #=> "content tiltel"
   #=> "cont end"


# attributes
doc.css("div").each do |elm|
  p elm['id']
end
   #=> "header"
   #=> "content"
   #=> "footer"


# map
doc.css("div").map { |e| puts e["id"]}

   #=> "header"
   #=> "content"
   #=> "footer"
