namespace :etymology do


#http://www.etymonline.com/index.php?l=a&allowed_in_frame=0

  
def parse_site_content(page: 0 ,letter: 'a', 
  url: 'http://www.etymonline.com/index.php?allowed_in_frame=0')
  
  dictionary = Dictionary.find_or_create_by(name: "Etymology Dictionary")
  
  url = "#{url}&p=#{page}&&l=#{letter}" 
  doc = Nokogiri::HTML(open(url)) 
  
  labels = doc.css('#dictionary dt')  
  doc.css('#dictionary dd').each_with_index do |link, idx|
    definition = link.content
    term = labels[idx].content
    
    puts '-' * 30
    puts term
    puts definition
   
    #term = link.css('.title a').text.downcase
    #definition = link.css('.entry').text.gsub(/\s+/, ' ')         
    #if term && definition       
     # Term.create(name: term.strip, definition: definition.strip, 
     # dictionary: dictionary)
    #end    
  end 
  total_pages = doc.css('.paging li').count / 2
  page += 1
  puts "***** Parsing next page! ************"
  parse_site_content(letter: letter, page: page) unless page > total_pages
end  
  
  desc "Etymology website parse"
  task parse_etymology_site: :environment do
    url = 'http://www.etymonline.com/index.php?allowed_in_frame=0&p=0&&l='  
    ('a'..'z').to_a.each do |letter| 
      #parse_site_content("#{url}#{letter}/")
      parse_site_content(letter: letter,  page: 58)
    end 
  end 

end
