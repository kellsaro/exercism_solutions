class DndCharacter

  def self.modifier(const)
    ((const - 10) / 2.0).floor
  end

  def self.roll(dice, times: 4)
    res = []
    times.times do
      res << dice.rand(1..6)
    end

    res
  end

  def dice
    @dice ||= Random.new
  end

  %i[strength dexterity constitution intelligence wisdom charisma].each do |method_name|
    define_method(method_name) do
      ivar = "@#{method_name}".to_sym
      instance_variable_get(ivar) || instance_variable_set(ivar, DndCharacter.roll(dice).sort[1..3].sum)
    end
  end

  def constitution_modifier
    @constitution_modifier ||= DndCharacter.modifier(constitution)
  end

  def hitpoints
    @hitpoints ||= 10 + constitution_modifier
  end
end
