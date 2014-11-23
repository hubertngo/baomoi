class ApplicationController < ActionController::Base
  protect_from_forgery
  require 'rufus-scheduler'
	scheduler = Rufus::Scheduler.new
	    scheduler.every '5m' do
	      Api::Vnnet.crawling
	    end
end
