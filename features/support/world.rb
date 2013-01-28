class TestWorld
  def persona
    @p ||= Persona.new(page)
  end
end

World { TestWorld.new }
