def init
  super
  # p sections
  sections.place(:ubbu).after(:box_info)
end

def ubbu
  '<h2>Sektion "ubbu"</h2>
  <div id="contents">Heute kein Inhalt.</div>
  '
end

