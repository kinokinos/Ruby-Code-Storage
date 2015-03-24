require 'rubygems'
require 'sqlite3'
require 'csv'

source_file='file_name'
db = SQLite3::Database.new(source_file)
CSV.open("to_filename",'w') do |csv| 
 db.execute('SELECT * FROM table_name') do |row|
  csv << row
 end
end
db.close


