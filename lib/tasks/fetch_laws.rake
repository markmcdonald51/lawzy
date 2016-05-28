require 'open-uri'

SKIP_TITLES = ["Chapter 1 THE COMPTROLLER OF THE CURRENCY",
 "Chapter 2 NATIONAL BANKS",
 "Chapter 3 FEDERAL RESERVE SYSTEM",
 "Chapter 4 TAXATION",
 "Chapter 5 CRIMES AND OFFENSES",
 "Chapter 6 FOREIGN BANKING",
 "Chapter 6A EXPORT IMPORT BANK OF THE UNITED STATES",
 "Chapter 7 FARM CREDIT ADMINISTRATION",
 "Chapter 7A AGRICULTURAL MARKETING",
 "Chapter 7B REGIONAL AGRICULTURAL CREDIT CORPORATIONS",
 "Chapter 8 ADJUSTMENT AND CANCELLATION OF FARM LOANS",
 "Chapter 9 NATIONAL AGRICULTURAL CREDIT CORPORATIONS",
 "Title 1 GENERAL PROVISIONS",
 "Title 10 ARMED FORCES",
 "Title 11 BANKRUPTCY",
 "Title 12 BANKS AND BANKING",
 "Title 13 CENSUS",
 "Title 14 COAST GUARD",
 "Title 2 THE CONGRESS",
 "Title 3 THE PRESIDENT",
 "Title 4 FLAG AND SEAL  SEAT OF GOVERNMENT  AND THE STATES",
 "Title 5 GOVERNMENT ORGANIZATION AND EMPLOYEES",
 "Title 6 DOMESTIC SECURITY",
 "Title 7 AGRICULTURE",
 "Title 8 ALIENS AND NATIONALITY",
 "Title 9 ARBITRATION"]





def get_links(doc: doc, css: '.nobullets li', r: r)
  if doc.at_css(css)
    doc.css(css).each do |li|

      if link = li.css('a')
        link.text =~ /(\d+)/
        h = {}
        link.first['href']
        h[:link] =  link.first['href']
        h[:title  ] = li.content.gsub(/\W/, ' ')
        
        
        next if SKIP_TITLES.include?(h[:title])

        if r.present?
          get_links(doc: get_doc(h[:link]), 
            r: r.children.create(title: h[:title], source: h[:link])  )
        else
          get_links(doc: get_doc(h[:link]), 
            r: Legal.create(title: h[:title], source: h[:link]) )
        end  
      end
    end
  else
    r.body = doc.css('pre').first.text
    r.save
    puts "...at the end of scope"
    puts r
    return
   end    
end

#repealed http://codes.lp.findlaw.com/uscode/7/6/I

def get_content(doc: doc, &block)
  yield doc.css('pre').first
end

def get_doc(url, &block)
  Nokogiri::HTML(open(url))
end

namespace :fetch_laws do
  desc "TODO"
  task fed: :environment do
    get_links(doc: get_doc('http://codes.lp.findlaw.com/uscode'))
    #get_links(doc: get_doc('http://codes.lp.findlaw.com/uscode/12'))

 
=begin    
    puts "### Search for nodes by xpath"
    doc.xpath('//nav//ul//li/a', '//article//h2').each do |link|
      puts link.content
    end

    puts "### Or mix and match."
    doc.search('nav ul.menu li a', '//article//h2').each do |link|
      puts link.content
    end
=end
    
  
  end

end
