#! ruby
# -*- coding: utf-8 -*- 
#requirement
##nokogiri

require 'nokogiri'
require 'csv'
# HTMLページのロード ############################
require 'open-uri'
lastpage=9 #最後のページ番号を入れる
tors={}
(0..lastpage).each do|page|
 doc = Nokogiri::HTML(open('https://blog.torproject.org/category/tags/tor-browser?page='+page.to_s))
  p 'https://blog.torproject.org/category/tags/tor-browser?page='+page.to_s
 
  doc.css("div.ntype-blog").each do |blog|
    version=blog.css("h2.title>a")
    if(version.to_s.match(/(>Tor.*released)/i))
    	p version=version.to_s.match(/>(Tor.*)(is)? released)/i)[1]
  	time= blog.css("span.submitted>abbr").to_s.match(/title=\"(.*)\">/)[1]
  	p day = blog.css("span.submitted>abbr").to_s.match(/">(.*)<\/abbr/)[1]	
        tors.store(version,day)

    end
   
   
  end
end

CSV.open("tor_version.csv","w") do |csv|
	tors.each do |a,b|
		csv << [a,b]
	end		
end 
