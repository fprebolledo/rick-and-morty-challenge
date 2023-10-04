require_relative 'rick_and_morty_client'

class CharCounterService

  def initialize
    client = RickAndMortyClient.new
    @locations = client.get_locations
    @episodes = client.get_episodes
    @characters = client.get_characters
  end

  def run
    resource_map = {'l': 'locations', 'e': 'episodes', 'c': 'characters' }
    results = resource_map.map { |char, resource| count_char_in_names(char.to_s, resource) }
  
    return results
  end

  private

  def count_char_in_names(char, resource_name)
    names = get_names(instance_variable_get("@#{resource_name}"))
    {
      char: char,
      count: ocurrences(names, char),
      resource: resource_name
    }
  end

  def get_names(list)
    list.map { |element| element["name"].downcase }
  end

  def ocurrences(strings, char)
    return 0 if strings.nil? || char.nil?
  
    strings.reduce(0) do |sum, string|
      if string.include?(char)
        sum += string.count(char)
      end
      sum
    end
  end
end
