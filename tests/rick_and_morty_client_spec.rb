require 'rspec'
require_relative '../src/rick_and_morty_client.rb'

RSpec.describe 'RickAndMortyClient' do
  let(:client) { RickAndMortyClient.new }

  describe '#get_content' do
    let(:url) { "https://rickandmortyapi.com/api/character" }
    context 'when url is ok' do
      it 'returns a 200 ok' do
        response = client.send('get_content', url)
        expect(response.length).to eq(2)
      end
    end

    context 'when url is not ok' do
      let(:url) { "https://rickandmortyapi.com/api/error" }
      it 'raises error' do
        expect { client.send('get_content', url) }.to raise_error(StandardError)
      end
    end
  end

  describe '#get_full_content' do
    context 'when resource is ok' do
      it 'returns content' do
        response = client.send('get_full_content', "location")
        expect(!!response.length).to eq(true)
      end
    end

    context 'when resource is not ok' do
      it 'raises error' do
        expect { client.send('get_full_content', 'error') }.to raise_error(StandardError)
      end
    end
  end
end
