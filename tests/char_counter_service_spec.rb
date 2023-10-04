require 'rspec'
require_relative '../src/char_counter_service.rb'
require_relative '../src/rick_and_morty_client.rb'

RSpec.describe 'CharCounterService' do
  let(:client) { CharCounterService.new }
  let(:rick_and_morty_double) do 
    double('RickAndMortyClient',
    get_locations: [{"name" => 'location1'}, {"name" => 'maipu'}],
    get_episodes: [{"name" => 'espisode1'}, {"name" => 'rick on rails'}],
    get_characters: [{"name" => 'rick'}, {"name" => 'morcty'}, {"name" => 'cname'}])
  end

  before do
    allow(RickAndMortyClient).to receive(:new).and_return(rick_and_morty_double)
  end

  describe '#ocurrences' do
    let(:strings) { ["rick", "morty", "summer", "beth", "jerry"] }
    let(:char) { "r" }

    context 'with missing char param' do
      it 'returns 0' do
        response = client.send('ocurrences', strings, nil)
        expect(response).to eq(0)
      end
    end

    context 'with missing strings params' do
      it 'returns 0' do
        response = client.send('ocurrences', nil, char)
        expect(response).to eq(0)
      end
    end

    context 'with both params' do
      let(:expected_result) { 5 }

      it 'returns correct result' do
        response = client.send('ocurrences', strings, char)
        expect(response).to eq(expected_result)
      end
    end
  end

  describe '#count_char_in_names' do
    let(:resource_name) { 'locations' }
    let(:char) { 'r' }
    let(:names) { ["rick", "morty", "summer", "beth", "jerry"] }
    let(:expected_result) { { char: char, count: 5, resource: resource_name } }

    before { allow(client).to receive(:get_names).and_return(names) }

    it 'returns correct result' do
      response = client.send('count_char_in_names', char, resource_name)
      expect(response).to eq(expected_result)
    end
  end

  describe '#run' do
    let(:expected_response) do
      [
        {char: 'l', count: 1, resource: 'locations'},
        {char: 'e', count: 2, resource: 'episodes'},
        {char: 'c', count: 3, resource: 'characters'}
      ]
  end

    it 'returns correct result' do
      response = client.run
      expect(response).to eq(expected_response)
    end
  end
end
