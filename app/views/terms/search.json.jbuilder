json.items @results do |r|
  json.id r.id

  #json.field_label hit.highlight(:field_label).format { |fragment| content_tag(:em, fragment) }
  json.field_label r.name

  # json.field_label hit.highlight(:field_note).format { |fragment| content_tag(:em, fragment) }
  
  json.source_name r.try(:dictionary).try(:name)
  # json.field_note truncate(r.definition, length: 25, separator: ' ') 
end
