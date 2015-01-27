#! ruby
# -*- coding: utf-8 -*- 
require 'nokogiri'
require 'csv'
# HTMLページのロード ############################
require 'open-uri'
doc = Nokogiri::HTML(open('http://cpubenchmark.net/CPU_mega_page.html'))
cpu={}
#puts doc.css("div>table>tbody>tr>td")

doc.css("div>table>tbody>tr").each do |trz|
	tra=trz.css("td")
	trb=tra.css("a")
#	tra=trz.css("td > a").last
	if((con =trb[1].to_s.match(/>(.*)</)))
		content=con[1].to_s
		aa=trz.css("td")[2]
		content2 =aa.to_s.match(/td>(.*)</)[1]
		cpu.store(content,content2.to_s)
	else
	#	puts "Not found"
	end
end
CSV.open("cpuall.csv","w") do |csv|
#	cpu_sort.each do |a,b|
	cpu.each do |a,b|
	#	puts a+":"+b
		csv << [a,b]
	end		
end 

CSV.foreach("cpuall.csv") do |bo|
 print bo , "\n"
end

