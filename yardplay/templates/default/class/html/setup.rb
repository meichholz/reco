def init
  super
  # p sections
  # %w(header box_info pre_docstring subclasses children constant_summary inherited_constants attribute_summary item_summary inherited_attributes method_summary item_summary inherited_methods constructor_details methodmissing attribute_details method_details_list)
  sections.place(:ubbu).after(:box_info)
end

def ubbu
  '<h2>Sektion "ubbu"</h2>
  <div id="contents">Heute kein Inhalt.</div>
  '
end

