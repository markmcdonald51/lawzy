json.items @results do |r|
  json.id r.id

  #json.field_label hit.highlight(:field_label).format { |fragment| content_tag(:em, fragment) }
  json.field_label r.name

  # json.field_label hit.highlight(:field_note).format { |fragment| content_tag(:em, fragment) }

  json.source_name r.try(:dictionary).try(:abbreviation) # if r.dictionary.id != 3
  json.definition r.definition
  # json.definition truncate(r.definition, length: 45, separator: ' ') 
end
