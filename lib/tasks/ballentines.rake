namespace :Ballentines do

  desc "1969_Ballentine pdf parse"
  task parse_ballentines_pdfs: :environment do
  
    file_path = "#{Rails.root}/db/imports/ballentines_1969"     
    ('a'..'z').to_a.each do |letter| 
      Docsplit.extract_text("#{file_path}/sec_#{letter}.pdf", {pdf_opts: '-raw', #'-layout',  
        output: "#{file_path}/sec_#{letter}.txt" }) 
        
    end 
  end 

end

