class PolyTreeNode

attr_reader :value, :children, :parent

  def initialize(value)
    @value = value
    @parent, @children = nil, []
  end 

  # def inspect
  #   { 'value' => @value, 'parent_value' => @parent.value }.inspect
  # end

  def parent
    @parent
  end 

  def children
    @children.dup 
  end 

  def value
    @value
  end 

  def parent=(parent)
    return self.parent if self.parent == parent
    
    if self.parent 
      self.parent._children.delete(self)
    end 

    @parent = parent 
    self.parent._children << self unless self.parent.nil?   
    
    self 
  end 

  def add_child(child)
    child.parent = self  
  end 

  def remove_child(child_node)
    parent = child_node 
  end 

  def _children
    @children
  end 
end
