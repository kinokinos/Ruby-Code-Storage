#! ruby
# -*- coding: utf-8 -*- 
require 'nokogiri'
require 'csv'
# HTMLページのロード ############################
require 'open-uri'
doc = Nokogiri::HTML(open('http://www.harddrivebenchmark.net/hdd_list.php'))
disk={}
#puts doc.css("center>table>tbody>tr>td")
doc.css("center>table>tbody>tr").each do |trz|
	tra=trz.css("td>a")

	if((con =tra[0].to_s.match(/>(.*)</)))
		content=con[1].to_s
		aa=trz.css("td")[1]
		content2 =aa.to_s.match(/td>(.*)</)[1]
		disk.store(content,content2.to_s)
	else
	#	puts "Not found"
	end
end
##SSD 
doc2 = Nokogiri::HTML(open('http://www.harddrivebenchmark.net/ssd.html'))
ssd=[]
doc2.css("div>table>tr").each do |trz|
	tra=trz.css("td")
 	trb=tra.css("a")
	if((con =trb[0].to_s.match(/>(.*)</)))
		content=con[1].to_s
		ssd.push(content)
	end
end
###

CSV.open("disk.csv","w") do |csv|
	disk.each do |a,b|
		if(ssd.include?(a.to_s))
			csv << [a,b,1] #SSD flag 
		else
			csv << [a,b]
		end
	end		
end 

CSV.foreach("disk.csv") do |bo|
 print bo , "\n"
end

