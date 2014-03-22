# wiki: https://mail.ag.freenet.ag/wiki/Tools/Yard
YARD::Tags::Library.define_tag("Please fix this issue", :FIXME)
YARD::Tags::Library.define_tag("Please fix this issue", :fixme)
YARD::Tags::Library.define_tag("Think about this", :think)
YARD::Tags::Library.define_tag("Think about this", :THINK)
YARD::Tags::Library.define_tag("Todo", :todo)
YARD::Tags::Library.define_tag("Todo", :TODO)
YARD::Tags::Library.define_tag("Todo List", :todolist)

# even the shortest path must contain 'default'
YARD::Templates::Engine.register_template_path File.dirname(__FILE__)

