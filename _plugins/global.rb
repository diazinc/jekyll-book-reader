
module Jekyll
  module AssetFilter
    def filterByTitleDate(posts)
		  n = posts.length

		  loop do
		    swapped = false

		    (n-1).times do |i|
		    	pstart = posts[i].path.rindex('/') + 1
		    	cstart = posts[i+1].path.rindex('/') + 1

		    	prev = posts[i].path[cstart .. cstart+9].gsub('-', '').to_f
		    	cur = posts[i+1].path[pstart .. pstart+9].gsub('-', '').to_f

		      if prev < cur
		        posts[i], posts[i+1] = posts[i+1], posts[i]
		        swapped = true
		      end
		    end

		    break if not swapped
		  end

		  num = 0
		  result = []

		  for post in posts
		  	if post['date-finished'] != nil then
		  		result[num] = post
		  		num += 1
				end
			end

			result

    end

    def filterByBookTitle(posts)

			result = posts.sort_by do |item|
			    item['book-title'].downcase
			end

			result

    end

    def filterLastDate(array)
    	n = array.length

		  loop do
		    swapped = false

		    (n-1).times do |i|

		    	prev = reverse_arr(array[i].gsub(' ', '').split('/')).join('').to_f
		    	cur = reverse_arr(array[i+1].gsub(' ', '').split('/')).join('').to_f

		      if prev < cur
		        array[i], array[i+1] = array[i+1], array[i]
		        swapped = true
		      end
		    end

		    break if not swapped
		  end

		  array
    	
    end

    def getNextPost(page)
    	p = page

    	loop do
    		if p.next == nil then
    			return nil    			
    		end
    		if p['next']['date-finished'] != nil then
    			break
    		else
    			p = p.next
    		end
    	end

    	return p.next

    end

    def getPreviousPost(page)
    	p = page

    	loop do
    		if p.previous == nil then
    			return nil    			
    		end
    		if p['previous']['date-finished'] != nil then
    			break
    		else
    			p = p.previous
    		end
    	end


    	return p.previous

    end

    def filterByLatestDate(posts)
		  n = posts.length

			loop do
		    swapped = false

		    (n-1).times do |i|

		    	prev = reverse_arr(filterFirstDate(posts[i]['book-finished']).gsub(' ', '').split('-')).join('').to_f
		    	cur = reverse_arr(filterFirstDate(posts[i]['book-finished']).gsub(' ', '').split('-')).join('').to_f

		      if prev > cur
		        array[i], array[i+1] = array[i+1], array[i]
		        swapped = true
		      end
		    end

		    break if not swapped
		  end
    end

    def getFileName(url)
    	sstart = url.rindex('/') + 12
    	send = url.rindex('.') - 1
    	return url[sstart..send].concat('.png').prepend('/img/book-covers/')
    end

    def getPermalink(post)
    	plink = '/reading'
    	title = post['book-title'].downcase.gsub(/[ ]+/, '-').gsub(/[-]*,[-]*/, '-').prepend('/').concat('-')
    	.concat(post['book-author'].downcase.gsub(/[ ]+/, '-'));
    	return plink.concat(title)
    end

    def reverse_arr(array)
	    half_length = array.length / 2
	    half_length.times {|i| array[i], array[-i-1] = array[-i-1], array[i] }
	    array
	  end

	  def getColorString(imgURL)
	  	# begin
		  colors = Miro::DominantColors.new(imgURL);
		  # rescue SystemCallError
		  	# return "#FFFFFF"
		  	

		  if colors.to_hex.length > 0 then
		  	# puts imgURL + '    :    ';
		  	# puts colors.to_hex
		  	return colors.to_hex[5]
		  else
		  	return "#FFFFFF"
		  end

	  end

  end
end

Liquid::Template.register_filter(Jekyll::AssetFilter)