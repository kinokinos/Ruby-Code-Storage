# -*- coding: utf-8 -*-
require 'win32ole'
 
DEBUG_SHOW = true
FILE_PATH  = "./cpuall-intel-aesni.xlsx"
FILE_PATH2  = "./Intel4.xlsx"


# Excelオブジェクト生成
excel = WIN32OLE.new('Excel.Application')
excel2 = WIN32OLE.new('Excel.Application')

# FileSystemObject生成
fso = WIN32OLE.new('Scripting.FileSystemObject')
fso2 = WIN32OLE.new('Scripting.FileSystemObject')

# デバッグ用表示
excel.visible = DEBUG_SHOW
 
begin
  # 指定したファイルを開く
  book = excel.Workbooks.Open(fso.GetAbsolutePathName(FILE_PATH))
  book2 = excel2.Workbooks.Open(fso2.GetAbsolutePathName(FILE_PATH2))
  ## 指定したシートを取得
  sheet = book.Worksheets(1)
  sheet2 = book2.Worksheets(1)
	t=0
	c=0
	f=0

################################ 
#ここから処理を作成
	sheet.UsedRange.Rows.each do |cell| #csv
		if(!cell.Columns(3).Value.nil?)
			break
		end
		intel=cell.Columns(1).Value.to_s
		puts intel=intel.gsub(/@.*/,"").to_s
#####		Reverse
		intel2=intel.split(" ")
		## "A 340" → A340
		if(intel.match(/[A-Z]\s[0-9]+/))
			intel2[-2]=(intel2[-2]+intel2[-1]).to_s
			intel2.pop(1)
			puts intel2
		end
		stlast=intel2.last.to_s
		intel3=intel2
		intel3.delete(intel2.last)
		intel3=intel3.join
		if(!alp=stlast.match(/[^0-9]+/))
			alp=""
		end
		if(!num=stlast.match(/[0-9]+/))
			num=""
		end
		puts intelr=intel3.to_s+num.to_s+alp.to_s
#####		
		sheet2.UsedRange.Columns.each do |cell2| #xml
			#cell.Rows(1).Value.to_s
			b=cell2.Rows(3).Value.to_s.gsub(/\s/,"").to_s
			if(b =~ /#{intel}.*/xi)
				if(!cell2.Rows(7).Value)
					puts cell.Columns(3).Value="NULL"
				else
					cell.Columns(3).Value=cell2.Rows(7).Value
					#AES-NIの有無
					cell.Columns(6).Value=cell2.Rows(119).Value 
				end
				book.save
				t+=1
				puts "t:#{t}"
				break
			elsif(b =~ /#{intelr}.*/xi) #1000A→A1000に変換
				cell.Columns(3).Value=cell2.Rows(7).Value
				#AES-NIの有無
				cell.Columns(6).Value=cell2.Rows(119).Value 
				book.save
				t+=1
				puts "t:#{t}"
				break
			else
				cell.Columns(3).Value="Miss"
			end
		f+=1
		end
		puts c+=1
	end		
	puts t
	puts f
	puts c
end


# 上書き保存
book.save
book.close
book2.close
excel.Quit

=begin
FILE_PATH3  = "./cpuall.csv"
excel3 = WIN32OLE.new('Excel.Application')
fso3 = WIN32OLE.new('Scripting.FileSystemObject')
book3 = excel3.Workbooks.Open(fso3.GetAbsolutePathName(FILE_PATH3))
sheet3 = book3.Worksheets(1)

book3.save
book3.close

  # ブックを閉じる
  book.close
  book2.close
 
  # Excel 終了
  excel.Quit
=end