namespace :BlacksLaw2 do

  desc "BLacks Law"
  task blacks_law_pdf_dump: :environment do
    file_path = "#{Rails.root}/db/imports/blacks-law-5th-complete_030812.pdf"
    file_path = "/media/removable/SD\ Card/blacks_law_dict/6th/Blacks\ Law\ 6th\ Edition\ -\ Sec.\ A.pdf"
     
    Docsplit.extract_text(file_path, {pdf_opts: '-raw', #'-layout',  
      output: 'blacks_6th_txt'})
     
  end

  def parse_line(l)
    term, definition = nil
    if (l =~ /^([A-Z]{1}.*?)\.(.*)/)
      term = $1
      definition = $2
    elsif l =~ /^\s{1,4}(\w.*)/
      definition = $1
    end 
    return [term, definition]
  end

  def save(term, definition)
    definition.gsub!(/��         A/, '')
    definition.gsub!(/\s+/, ' ')
    puts '*' * 30
    puts "new_term: #{term}"
    puts "new_def: #{definition}"
    
    sleep 1
  end
  
  desc "Blacks Law File parse"
  task blacks_txt2_parse: :environment do
    start = false
    right_side = ''; left_side = ''
    full_page = ''
    term, definition = nil
    file = File.open('blacks_law_single_strans.txt','w');
    
    File.open("#{Rails.root}/db/imports/blacks_6th_txt/sec-_a1.txt").each_line do |l|
      if start == false && l !~ /\W{55}A$/
        next
      else
        start = true
      end  

      next if l =~ /SIXTH EDITION/
      #right_side, left_side = l[0..60], l[61..-1]   
      
      if l !~ /^\014/    
        next if l.blank? 
        puts l
        
        lft, rgt = l[0..62], l[63..-1]               
        split_line = l[50..73].split(/\s{2,}/) if l[50..73].present?
          
        
        if lft.present? 
          if l_length = split_line.try(:first).try(:length)
            left_index = l.index(split_line.first) + l_length
            left_side <<  l[0..left_index] << "\n"
          else
            left_side << lft
          end           
        end  
        
        if rgt.present?
         if r_length = split_line.try(:second).try(:length)
          right_index = l.index(split_line.second)-2 
          right_side   << l[right_index..-1].to_s
         else
          right_side << rgt
         end
         
        end
        
      else
        
        full_page = left_side
        full_page  << right_side
        right_side = ''; left_side = ''       
        file.write(full_page)
      end
    end   
=begin
      new_term, new_definition = parse_line(right_side)
      
      next if new_term.blank? && new_definition.blank?
     
      if new_term.present?
        save(term, definition) unless definition.blank?   
        term = new_term
        definition = "#{new_definition}"
      else
        definition << new_definition    
      end 
    end
=end    
  end
end
