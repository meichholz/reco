def init
  super
  sections.place(:todolist).after(:box_info)
end

def todolist
  return unless object.has_tag?(:todolist)
  @items = Array.new
  add_todo_items @items, "FIXME", :fixme, :FIXME
  add_todo_items @items, "TODO", :todo, :TODO
  add_todo_items @items, "Thinks again", :think, :THINK
  out = @items.empty? ? nil : erb(:todolist)
  @items = nil
  out
end

def add_todo_items(items, header, tag1, tag2)
  codos = todo_codo_list(tag1, tag2)
  return nil if codos.empty?
  items << { header: header, codos: codos }
end

#  @return [Array] all items that have tags with given name 
def todo_codo_list(*tags)
  YARD::Registry.all.select do |codo|
    rc = false
    tags.each do |tag|
      rc ||= codo.tag(tag)
    end
    rc
  end
end


