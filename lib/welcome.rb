require './lib/haunted_house'

@flags = []
@flags[18] = @flags[17] = @flags[2] = @flags[26] = @flags[28] = @flags[23] = true
@carrying = []
HauntedHouse.new(@flags, @carrying).welcome