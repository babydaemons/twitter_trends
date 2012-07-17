#!ruby
# coding: utf-8

require 'time'

class MainController < ApplicationController
  def index
    @hours = { 0 => "今すぐ", 6 => "６時間前", 12 => "半日前", 24 => "１日前", 24 * 7 => "１週間前", 24 * 30 => "１ヶ月前" }; @hours.default = @hours[0]
    @spans = { "HOUR" => "時間", "DAY" => "日", "WEEK" => "週間", "MONTH" => "ヶ月" }; @spans.default = @spans["HOUR"]

    @from = Time.now - (params[:from].to_i * 3600)
    @crawled = Hit.crawled
    @span = (@spans.include? params[:span]) ? params[:span] : "HOUR"
    @summary = Hit.summary @from, @span
    #render :json => { :summary => @summary }
  end

  def go
    @keyword_id = params[:keyword_id]
    @keyword = Keyword.find(@keyword_id).keyword
    @wanted = params[:wanted]
    begin
      @since = Time.parse params[:since]
    rescue
      @since = Time.now - (params[:hours].to_i * 3600)
    end
    @page = params[:page].to_i; @page = 1 if @page < 1
    @matched = Hit.match(params[:keyword_id].to_i, @wanted, @since, @page)
  end
end
