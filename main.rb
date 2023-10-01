require_relative './src/episode_location_service.rb'
require_relative './src/char_counter_service.rb'

def main_char_counter
  t0 = Time.now
  results = CharCounterService.new.run
  run_time = Time.now - t0

  return {
          exercice_name: 'Char counter',
          time: run_time,
          in_time: run_time < 3,
          results: results
        }
end

def main_episode_location
  t0 = Time.now
  results = EpisodeLocationService.new.run
  run_time = Time.now - t0
  return {
          exercice_name: 'Episode locations',
          time: run_time,
          in_time: run_time < 3,
          results: results
        }
end

char_counter_result = main_char_counter
episode_locations_result = main_episode_location

exercices = [
  char_counter_result,
  episode_locations_result
]

puts exercices