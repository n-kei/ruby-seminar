# encoding: utf-8

begin
	r_file = open(ARGV[0], "r")
	w_file = open(ARGV[1], "w")
rescue TypeError #コマンドライン引数がなかった時の例外処理
	puts "usage: ruby report1.rb <input file name> <output file name>"	
	exit
rescue Errno::ENOENT #入力ファイルが存在しなかった時の例外処理
	puts "error: #{ARGV[0]} doesn't exist."
	exit
end

def r_file.sort_tsv(write_file, item_num)
	data_array = Array.new
	reg_str = String.new

	self.each_line { |line| data_array << line}

	# tsvファイルの各要素をキャプチャするための正規表現の文字列を作成
	if item_num > data_array[0].split("\t").size
		# オブジェクトメソッドの中でprintとかputsを使うとそのオブジェクトをレシーバとしてメソッドが実行されるらしい？よくわからん。下だとダメだった
		# puts "error: the value you requested may exceed the upper limit."
		STDOUT.print "error: the value you requested may exceed the upper limit.\n"
		write_file.close
		self.close
		exit
	end

	data_array[0].split("\t").size.times do
		reg_str += "(.*)\t"
	end

	reg_str.strip!
	reg_str += "\n"
	reg = Regexp.new(reg_str)

	data_array.sort_by! do |tsv_str|
		reg =~ tsv_str
		Regexp.last_match( item_num )	
	end

	data_array.each { |tsv_str| write_file.print tsv_str}
end

print "何番目の要素を比較しますか："
STDOUT.flush
# ARGVとgetsを併用するとエラーが出る。下だとダメだった
# item_num = gets.chomp.to_i
item_num = STDIN.gets.chomp.to_i
r_file.sort_tsv(w_file, item_num)
r_file.close
w_file.close
