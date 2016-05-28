namespace :Bouviers do

=begin
  rails g scaffold Dictionary name:string description:string edition:string position:integer
  rails g scaffold Terms name:string definition:text parent_id:integer, dictionary:references position:integer
  
  root      = Category.create("name" => "root")
  child1    = root.children.create("name" => "child1")
  subchild1 = child1.children.create("name" => "subchild1")
=end

  desc "File parse"
  task parse: :environment do
  

    dictionary = Dictionary.find_or_create_by(name: 'Bouviers')

    #doc Nokogiri::HTML(open('http://www.constitution.org/bouv/bouvier_a.htm'))
    ('b'..'z').to_a.each do |letter| 
      doc = Nokogiri::HTML(open("http://www.constitution.org/bouv/bouvier_#{letter}.htm"))  
      puts "### Search for nodes by css"
      last_definition = nil
      
      doc.css('p').each do |link|
        puts link.content
        term = link.css('b').text
        definition = link.text
        next if term == "Index"
        
        if definition =~ /^\d+\. \w+/ && term.blank?
          last_definition.children.create(definition: definition)
          next    
        elsif term.present?
          last_definition = Term.create(name: term, definition: definition, dictionary: dictionary)
          puts last_definition
        end
      end
    end    
  end
  
  
  desc "Get Maxims"
  task parse_maxims: :environment do
 
    dictionary = Dictionary.find_or_create_by(name: 'Maxims of Law')
    doc = Nokogiri::HTML(open('http://www.lawfulpath.com/ref/bouvier/maxims.shtml')) 
    puts "### Search for nodes by css"
    last_definition = nil
    
    doc.css('p').each do |link|
      puts link.content
      
      parts = link.text.split('.')
      term = parts.shift << '.'
      definition = parts.join('.')
      Term.create(name: term, definition: definition, dictionary: dictionary)
    end
  end
  
  desc "Webster Dict File parse"
  task parse_webster: :environment do
    dictionary = Dictionary.find_or_create_by(name: "1913 US Webster's Unabridged Dictionary")

    ('a'..'z').to_a.each do |letter| 
      doc = Nokogiri::HTML(open("http://www.mso.anu.edu.au/~ralph/OPTED/v003/wb1913_#{letter}.html"))   
      doc.css('p').each do |link|
        puts link.content
        term = link.css('b').text
        link.text =~ /^\w+ \(.*?\) (.*)/
        definition = $1
        part_of_speech = link.css('i').text
        
        if t = Term.find_by(name: term, dictionary: dictionary)
          t.children.create(part_of_speech: part_of_speech, definition: definition)
        else
          Term.create(name: term, definition: definition, 
            dictionary: dictionary, part_of_speech: part_of_speech)
        end
      end  
    end
  end  
end
