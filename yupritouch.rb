gem 'pdf-reader'

require 'open-uri'
require 'active_support'
require 'active_support/core_ext/object/json'
require 'pdf-reader'

array = open 'http://www.post.japanpost.jp/notification/pressrelease/2017/00_honsha/0619_01_02.pdf' do |h|
  PDF::Reader.new(h).pages.map{|p| p.text.split}
end.flatten

list = []
a = array.shift(3)

loop do
  if a[1] =~ /\d\d\d-\d\d\d\d/
    list << {name: a[0], zip: a[1], addr: a[2]}
    a = array.shift(3)
  else
    a.shift
    a << array.shift
  end
  break if a[2].nil?  
end

puts list.to_json

