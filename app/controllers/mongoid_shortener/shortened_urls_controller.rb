module MongoidShortener
  class ShortenedUrlsController < ApplicationController
    # find the real link for the shortened link key and redirect
    def translate
      # Figure out the length
      begin
        prefix_len = MongoidShortener.prefix_len
      rescue NoMethodError
        prefix_len = 1
      end
      # pull the link out of the db
      sl = ShortenedUrl.where(:unique_key => params[:unique_key][prefix_len..-1]).first

      if sl
        sl.inc(:use_count, 1)
        # do a 301 redirect to the destination url
        head :moved_permanently, :location => sl.url
      else
        # if we don't find the shortened link, redirect to the root
        # make this configurable in future versions
        head :moved_permanently, :location => MongoidShortener.root_url
      end
    end
  end
end
