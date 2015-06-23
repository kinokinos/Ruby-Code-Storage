#!ruby -Ks
#USAGE:  ruby bench.rb INPUT_CSV
#CSVの行列数を調べる速さ確認
require 'csv'
require 'benchmark'

filename=ARGV[0]
if(!filename)
	p "USAGE: ruby bench.rb INPUT_CSV"
end
Encoding.default_external = 'UTF-8'

#====TEST======
#slow
# 6.047000   0.438000   6.485000 (  6.760062)
puts Benchmark.measure { 
		excel=[]
		CSV.foreach(filename) do |j|
			excel.push(j)
		end
}
#fast
# 5.891000   0.344000   6.235000 (  6.238521)
puts Benchmark.measure { 
		cell=0;cell2=0
		CSV.foreach(filename) do |j|
			cell=j.length #50
			cell2+=1
		end
}
