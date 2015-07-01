class Author
  attr_accessor :year_of_birth, :year_of_death, :name

  def initialize year_of_birth, year_of_death, name
    @year_of_birth = year_of_birth
    @year_of_death = year_of_death
    @name = name
  end

  def can_meet? other_author
  	life_time_first = (@year_of_birth..@year_of_death)
  	life_time_second = (other_author.year_of_birth..other_author.year_of_death)
  	life_time_first.overlaps? life_time_second 
  end
end
