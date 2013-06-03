require "sinatra"
require "movies"
require "stock_quote"
require "image_suckr"

get "/" do
  erb :index
end

get "/movies" do
  unless params["mtitle"].nil?
  	@movie = Movies.find_by_title(params["mtitle"])

  end
  erb :movies

end

get "/stocks" do
  unless params["symbol"].nil?
  	begin
  		@s = params["symbol"]
  		@company = StockQuote::Stock.quote(@s.upcase)
  	rescue
  		@company = nil 
  		@s = nil
  	end
  end

  erb :stocks
end


get "/images" do

	unless params["query"].nil?
		begin
			@q = params["query"]
			suckr = ImageSuckr::GoogleSuckr.new  
			@src = suckr.get_image_url({"q" => "#{@q}"})
		rescue
			@q = nil
			@src = nil
		end
	end

  erb :images
end



