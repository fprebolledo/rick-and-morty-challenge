require 'uri'
require 'json'
require 'net/http'

class RickAndMortyClient
  @@BASE_URL = "https://rickandmortyapi.com/api".freeze
  
  def get_characters
    return get_full_content("character")
  end

  def get_locations
    return get_full_content("location")
  end
  
  def get_episodes
    return get_full_content("episode")
  end

  private

  def get_full_content(type)
    url = full_url(type)
    get_content(url)
  end
  
  def full_url(type)
    url = "#{@@BASE_URL}/#{type}"
    count = get_content(url)["info"]["count"]
    count_concatenate_string = (1..count).to_a.join(",")

    "#{url}/#{count_concatenate_string}"
  end

  def get_content(url)
    uri = URI(url)
    response = JSON.parse(Net::HTTP.get(uri))
    raise StandardError.new('Bad request') unless response

    response
  end
end