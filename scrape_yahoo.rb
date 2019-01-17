
#webにアクセスするためのライブラリ
require 'open-uri'
#スクレイピングに使用するライブラリ
require 'nokogiri'

#スクレーピングするURLを指定
url = "https://news.yahoo.co.jp/topics"

charset = nil
html = open(url) do |page|
  # 文字種別を取得
  charset = page.charset
  #Pageの中身を読む
  page.read
end

# htmlをパース(解析)してオブジェクトを生成
documents = Nokogiri::HTML.parse(html, nil, charset)

# CSSセレクターで抽出する場合
puts "    "
puts "**********CSS Selector*********"
puts "    "

# "searchResult_itemTitle"がクラス名の配下にあるHTML情報を取得
contents = documents.css(".fl")
#
contents.each do |content|
  title = content.css('a')[1].inner_text
  url = content.css('a[href]')[1]['href']
  puts title + " : " + url
end


puts "    "
puts "**********Xpath*********"
puts "    "

xpath_contents = documents.xpath('//*[@class="fl"]/li/a')

xpath_contents.each do |content|
  title = content.inner_text
  url = content['href']
  puts title + " : " + url
end
