
def init
    super
    sections[:layout].insert(0, :navbar)
end

def navbar
  erb(:navbar)
end

def menu_lists
  super + [ { type: 'todolist', title: 'Todo List', search_title: 'Undone List' } ]
  # note: "type:" refers to the generator method (generate_x_list)
end
