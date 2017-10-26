require 'vacuum'
require 'pp'

class Product 
  attr_accessor :asin, :title, :author, :price, :url, :image, :salesrank
  def show
    puts title
    puts author
    puts price
    puts image
    puts asin
    puts salesrank
    puts "\n\n"
  end
end

class Amazon

  def initialize
    @request = Vacuum.new

    @request.configure(
      aws_access_key_id: 'YOUR_API_KEY',
      aws_secret_access_key: 'YOUR_API_SECRET_KEY',
      associate_tag: 'YOUR_AMAZON_ASSOCIATE_TAG'
    )
  end

  def search_by_keyword(keyword, page)
    response = @request.item_search(
      query: {
        'Keywords' => keyword,
        'SearchIndex' => 'All',
        'ResponseGroup' => 'ItemAttributes,OfferSummary,Images,SalesRank',
        'ItemPage' => page
      }
    )
    return response
  end

  def item_lookup(asin)
    response = @request.item_lookup(
      query: {
        'ItemId' => asin,
        'IncludeReviewsSummary' => false,
        'ResponseGroup' => 'Reviews'
      }
    )
    return response
  end

  def format_hash(keyword)
    products = []
    pages =* (1..4)
    # Iterate through 5 pages
    pages.each do |page|
      sleep 1
      response = search_by_keyword(keyword, page)
      amazon_hash = response.to_h
    
      amazon_hash['ItemSearchResponse']['Items']["Item"].each do |item|
          #pp item
          # Only take item with price and image
          price = item['ItemAttributes']['ListPrice'] rescue true
          image = item['LargeImage'] rescue true
          salesrank = item['SalesRank'] rescue true
          unless !(price && image && salesrank)
            product = Product.new
            product.title = item['ItemAttributes']['Title']
            # Check if author is array or not, take the first author.
            if !defined?(item['ItemAttributes']['Author'])
              product.author = item['ItemAttributes']['Author'][0]
            else
              product.author = item['ItemAttributes']['Author']
            end
            product.url = item['DetailPageURL']
            product.price = item['ItemAttributes']['ListPrice']['FormattedPrice']
            product.image = item['LargeImage']['URL']
            product.asin = item['ASIN']
            product.salesrank = Integer(item['SalesRank'])
            #product.show
            (products ||= []) << product
          end
      end
    end
    # Take first 14 - Highest Ranker/Popular Items
    products = products.sort_by{|pr| pr.salesrank}[0..25]
    return products
  end

  def reviews_iframe(asin)
    response = item_lookup(asin)
    amazon_hash = response.to_h
    iframe_url = amazon_hash['ItemLookupResponse']['Items']['Item']['CustomerReviews']['IFrameURL']
    return iframe_url
  end

end


#amazon = Amazon.new
#response = amazon.search_by_keyword('One Piece Manga')
#amazon.format_hash('One Piece Manga')
