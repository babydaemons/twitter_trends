#!ruby
# coding: utf-8

require 'cgi'

module MainHelper
  def status_url(tweet)
    "https://twitter.com/#!/#{tweet.from_user}/status/#{tweet.status_id}"
  end

  def profile_url(tweet)
    "https://twitter.com/#!/#{tweet.from_user}"
  end

  def rewrite_tweet(tweet)
    text = tweet.text
    re1 = /(https?:\/\/[-_.!~*\'()a-zA-Z0-9;\/?:\@&=+\$,%#]+)/
    text = rewrite_all(text, re1) {|v| "<a href=\"#{v}\" target=\"_blank\">#{v}</a>"}
    re2 = /(@[A-Za-z0-9_]+)/ 
    text = rewrite_all(text, re2) {|v| "<a href=\"http://twitter.com/#!/#{v[1..-1]}\" target=\"_blank\">#{v}</a>"}
    re3 = /(#[^\s\(\)\[\]\{\}<>!?:;.,"']+)/ 
    text = rewrite_all(text, re3) {|v| "<a href=\"http://twitter.com/search?q=#{CGI.escape(v)}\" target=\"_blank\">#{v}</a>"}
  end

  def rewrite_all(text, regexp, &block)
    result = ""
    while text =~ regexp
      words = text.split($1, 2)
      result += words[0] + block.call($1)
      text = words[1] || ""
    end
    result + text
  end

  PAGES = 10
  def page_navi(page, keyword_id, since, wanted)
    links = [ link_to("再検索", "/") ]
    if page > 1 then
      link = link_to("<<", :action => "go", :page => (page - 1).to_s, :keyword_id => keyword_id, :since => since, :wanted => wanted)
      links.push link
    end
    1.upto(PAGES) do |i|
      if i == page then
        link = i.to_s
      else
        link = link_to(i.to_s, :action => "go", :page => i.to_s, :keyword_id => keyword_id, :since => since, :wanted => wanted)
      end
      links.push link
    end 
    if page < PAGES then
      link = link_to(">>", :action => "go", :page => (page + 1).to_s, :keyword_id => keyword_id, :since => since, :wanted => wanted)
      links.push link
    end
    links.join("&nbsp;")
  end

  # http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-list/37580
  def num_fmt(num)
    num.to_s.reverse.gsub( /(\d{3})(?=\d)/, '\1,' ).reverse
  end

  def parse_record(records)
    summary = {}
    counts = {}; counts.default = 0
    timeslot = -1
    records.each do |record|
      break if record.timeslot > 24
      if record.timeslot != timeslot then
        timeslot = record.timeslot
        summary[timeslot] = counts.dup
      end
      summary[record.timeslot][record.keyword_id] = record.count
    end
    summary
  end
end
