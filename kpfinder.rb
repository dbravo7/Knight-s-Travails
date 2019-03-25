require "byebug"
class KPFinder

    def self.valid_moves(pos)
      
    end    

    def initialize(start)
      @start_position = start
    #   @root_node = PolyTreeNode.new(@root_node)
      @considered_positions = [start]
    #   build_move_tree(@root_node)
    end 

    def build_move_tree(root)
      
    end 

    def new_move_positions(pos)
      poss_x = [-1,1,-2,-2,-1,1,2,2]
      poss_y = [-2,-2,-1,1,2,2,-1,1]
      new_positions = []

      poss_x.zip(poss_y) do |x_pos, y_pos|
        new_pos = [pos.first + x_pos, pos.last + y_pos]
        if !@considered_positions.include?(new_pos) #&& KPFinder.valid_moves(new_pos)
            @considered_positions << new_pos
            new_positions << new_pos 
        end 
      end 
      new_positions  
      debugger 
    end 

end 


if $PROGRAM_NAME == __FILE__
  KPFinder.new([4,4])
end 