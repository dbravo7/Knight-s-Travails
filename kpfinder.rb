require "byebug"
require_relative "ptnode"
class KPFinder

attr_reader :root_node, :considered_positions

    def self.valid_moves(pos)
      x, y = pos 
      if x >= 0 && x <= 7 && y >= 0 && y <= 7
        return true
      end 
      false 
    end    

    def initialize(start)
      @start_pos = start 
      @root_node = PolyTreeNode.new(start)
      @considered_positions = [@root_node]
      build_move_tree([@root_node])
    end 

    def build_move_tree(start_node)
      queue = start_node
      until queue.empty? 
        # debugger 
        node = queue.pop 
        queue = new_move_positions(node) + queue 
      end 
      queue 
    end 

    def new_move_positions(node)
      poss_x = [-1,1,-2,-2,-1,1,2,2]
      poss_y = [-2,-2,-1,1,2,2,-1,1]
      pos = node.value
      new_positions = []
      # debugger 
      poss_x.zip(poss_y) do |x_pos, y_pos|
        new_pos = [pos.first + x_pos, pos.last + y_pos]
        if considered_positions(new_pos) && KPFinder.valid_moves(new_pos)
            new_node = PolyTreeNode.new(new_pos)
            new_node.parent = node 
            @considered_positions << new_node 
            new_positions.unshift(new_node) 
        end 
      end 
      new_positions 
    end 

    def considered_positions(pos)
      # debugger 
      @considered_positions.each do |tile|
        return false if tile.value == pos
      end 
      true 
    end 

  def find_path(root=@root_node, end_pos)
    # return nil if root.nil? 
    return trace_path_back(root) if root.value == end_pos
    root.children.each do |child|
      search_result = find_path(child, end_pos)
      p search_result unless search_result.nil?
    end
    nil
  end 

  def trace_path_back(end_pos)
    path = [end_pos.value]
    node = end_pos.parent
    until node.nil? 
      path.unshift(node.value)
      node = node.parent
    end 
    path 
  end 
end 


if $PROGRAM_NAME == __FILE__
  kpf = KPFinder.new([0,0])
  kpf.find_path([7,7])
end 