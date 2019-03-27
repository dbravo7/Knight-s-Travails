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
      @considered_positions.each do |tile|
        return false if tile.value == pos
      end 
      true 
    end 

  def find_path(end_pos)
    debugger 
    return end_pos if end_pos == @start_pos
    path = []
    parent = (find_path(trace_path_back(end_pos)))
    path << parent 
    path.map {|tile| tile.value}
  end 

  def trace_path_back(pos)
    debugger 
    @considered_positions.each do |tile|
      return tile.parent if tile.value == pos
    end 
  # should return values in order from the start position to the end position
  # Use to finish up find_path 
  end 
end 


if $PROGRAM_NAME == __FILE__
  kpf = KPFinder.new([0,0])
  kpf.find_path([7,6])
end 