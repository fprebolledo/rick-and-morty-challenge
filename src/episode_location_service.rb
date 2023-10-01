require_relative 'rick_and_morty_client'

class EpisodeLocationService
  def initialize
    client = RickAndMortyClient.new
    @episodes = client.get_episodes
    @characters = client.get_characters
    @locations = client.get_locations
    @characters_origin = {}
    set_characters_origin
  end
  
  def run
    @episodes.map do |episode|
      character_ids = get_characters_ids(episode)
      get_episode_hash(episode, character_ids)
    end
  end

  private

  def get_characters_ids(episode)
    episode["characters"].map { |character| character.split("/").last }
  end
  
  def get_characters_origin_name(character_ids)
    character_ids.map { |id| @characters_origin[id.to_i] }.uniq
  end
  
  def set_characters_origin
    @characters.each do |character|
      @characters_origin[character["id"]] = character["origin"]["name"]
    end
  end

  def get_episode_hash(episode, character_ids)
    {
      name: episode["name"],
      episode: episode["episode"],
      locations: get_characters_origin_name(character_ids)
    }
  end
end
