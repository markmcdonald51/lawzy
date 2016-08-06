namespace :etymology do


#http://www.etymonline.com/index.php?l=a&allowed_in_frame=0

  
def parse_site_content(url)
  dictionary = Dictionary.find_or_create_by(name: "Etymology Dictionary")
  doc = Nokogiri::HTML(open(url)) 
  
  labels = doc.css('#dictionary dt')
   
  doc.css('#dictionary dd').each_with_index do |link, idx|
    definition = link.content
    term = labels[idx].content
    binding.pry
    
    #term = link.css('.title a').text.downcase
    #definition = link.css('.entry').text.gsub(/\s+/, ' ')         
    #if term && definition       
     # Term.create(name: term.strip, definition: definition.strip, 
     # dictionary: dictionary)
    #end    
  end 
  parse_site_content(doc.css('.next').first['href']) if doc.css('.next').try(:first) 
end  
  
  desc "Etymology website parse"
  task parse_etymology_site: :environment do
    url = 'http://www.etymonline.com/index.php?allowed_in_frame=0&l='  
    ('a'..'z').to_a.each do |letter| 
      parse_site_content("#{url}#{letter}/")
    end 
  end 

end
