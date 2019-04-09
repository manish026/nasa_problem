  
  class Plateau 
    
    attr_accessor :x_max , :y_max 


    def initialize(size_in_string)
      size = size_in_string.split
      @x_max = size[0].to_i
      @y_max = size[1].to_i
    end

  end


  class Direction 

  # Clockwise
  # 1 - N 
  # 2 - E 
  # 3 - S
  # 4 - W

    attr_accessor :current_direction
    

    def initialize(current_direction)
      @current_direction = get_numerical_direction_for(current_direction)
    end


    def get_current_direction
      get_string_direction
    end


    def get_numerical_direction_for( direction )
  	
  	  case direction 
  	  when "N" then 1
      when "E" then 2
      when "S" then 3
      when "W" then 4
      end
  
    end


    def get_string_direction
      
      case @current_direction
      when 1 then "N"
      when 2 then "E"
      when 3 then "S"
      when 4 then "W"
      end

    end

    def turn_right
  	  @current_direction += 1
  	  @current_direction = 1 if @current_direction > 4
    end
  
  
    def turn_left
      @current_direction -= 1 
  	  @current_direction = 4 if @current_direction < 1
    end

  end


  class Rover

  	attr_accessor :current_direction, :current_x, :current_y, :direction, :movements, :plateau


  	def initialize(x, y, direction, path, plateau)
  	  @current_x = x
  	  @current_y = y
  	  @direction = Direction.new(direction)
  	  @movements = path
  	  @plateau = plateau
  	end


    def start
      movements.each_char do |movement| 
        direction.turn_left if movement == "L"
        direction.turn_right if movement == "R"
        move_forward if movement == "M"
      end
    end
    
  
    def move_forward
  	  case direction.current_direction
  	  when 1 then @current_y = increment(@current_y, plateau.y_max)
  	  when 2 then @current_x = increment(@current_x, plateau.x_max)
  	  when 3 then @current_y = decrement(@current_y, plateau.y_max)
  	  when 4 then @current_x = decrement(@current_x, plateau.x_max)	
  	  end
    end


    def increment(direction, maxSize) 
      return direction += 1
      return 1 if direction > maxSize
    end
   

    def decrement(direction, maxSize) 
      return direction -= 1
      return maxSize if direction < 0
    end


    def rover_direction
      direction.get_current_direction
    end

  end


  class MarsMission 

  
    def start
  	  puts "Enter size of plateau as x y example: 5 5"
      plateau_size = gets
      plateau = Plateau.new(plateau_size)
  
  
      while true
      	
        puts "Enter initial position and direction example: 1 1 N"
        position = gets.split
        rover_x_coordinate = position[0].to_i
        rover_y_coordinate = position[1].to_i
        rover_direction = position[2]
        
      
        puts "Enter movements example: LMLMLMLMM"
        movements = gets
      
        rover = Rover.new(rover_x_coordinate, rover_y_coordinate, rover_direction, movements, plateau)
        rover.start
        puts "#{ rover.current_x } #{ rover.current_y } #{ rover.rover_direction }"
      
      end
    	
    end

  end

  
  MarsMission.new.start
  

  


