require 'rspec'
require_relative '../src/episode_location_service.rb'
require_relative '../src/rick_and_morty_client.rb'

RSpec.describe 'EpisodeLocationService' do
  let(:client) { EpisodeLocationService.new }
  let(:rick_and_morty_double) do 
    double('RickAndMortyClient',
    get_episodes: [
      {"name" => 'episode1', "episode" => "S01E01", "characters" => ['api://characters/1', 'api://characters/3']},
      {"name" => 'rick on rails', "episode" => "S01E02", "characters" => ['api://characters/2']}
    ],
    get_characters: [
      {"id" => 1, "origin" => { "name" => "origin1"}},
      {"id" => 2, "origin" => { "name" => "origin2"}},
      {"id" => 3, "origin" => { "name" => "origin1"}}
    ]
  )
  end

  before do
    allow(RickAndMortyClient).to receive(:new).and_return(rick_and_morty_double)
  end

  describe '#get_characters_origin_name' do
    let(:character_ids) { ['1', '3'] }
    context 'with two same origin' do
      it 'returns not repeated origin' do
        response = client.send('get_characters_origin_name', character_ids)
        expect(response.length).to eq(1)
      end
    end

    context 'with different origin names' do
      let(:character_ids) { ['1', '2'] }
      it 'returns correct value' do
        response = client.send('get_characters_origin_name', character_ids)
        expect(response.length).to eq(2)
      end
    end
  end

  describe '#run' do
    let(:expected_response) do
      [
        {name: 'episode1', episode: "S01E01", locations: ['origin1']},
        {name: 'rick on rails', episode: "S01E02", locations: ['origin2']},
      ]
  end

    it 'returns correct result' do
      response = client.run
      expect(response).to eq(expected_response)
    end
  end
end
