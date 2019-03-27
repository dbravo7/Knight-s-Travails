require "byebug"
require_relative "ptnode"
class KPFinder

attr_reader :root_node, :considered_positions, :target

    def self.valid_moves(pos)
      x, y = pos 
      if x > 0 && x < 8 && y > 0 && y < 8
        return true
      end 
      false 
    end    

    def initialize(start, target)
      @target = target 
      @root_node = PolyTreeNode.new(start)
      @considered_positions = [start]
      build_move_tree([@root_node.value], target)
    end 

    def build_move_tree(start_pos, target)
      queue = start_pos
      until queue.nil? 
        pos = queue.pop 
        break if pos == target 
        debugger 
        queue = new_move_positions(pos) + queue 
      end 
      queue 
    end 

    def new_move_positions(pos)
      poss_x = [-1,1,-2,-2,-1,1,2,2]
      poss_y = [-2,-2,-1,1,2,2,-1,1]
      new_positions = []
    debugger 
      poss_x.zip(poss_y) do |x_pos, y_pos|
        new_pos = [pos.first + x_pos, pos.last + y_pos]
        if !@considered_positions.include?(new_pos) && KPFinder.valid_moves(new_pos)
            node = PolyTreeNode.new(new_pos)
            node.parent = pos 
            @considered_positions << node.value
            new_positions.unshift(node.value) 
        end 
      end 
      new_positions 
    end 

end 


if $PROGRAM_NAME == __FILE__
  KPFinder.new([0,0], [7,7])
end 