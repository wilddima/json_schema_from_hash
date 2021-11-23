# frozen_string_literal: true

RSpec.describe JsonSchemaFromHash::Parser do
  describe '#call' do
    let(:parser_call) { described_class.new(entity).call }

    context 'entity is a integer' do
      let(:entity) { 1 }

      it 'parses number' do
        expect(parser_call).to eq :number
      end
    end

    context 'entity is a float' do
      let(:entity) { 0.123 }

      it 'parses number' do
        expect(parser_call).to eq :number
      end
    end

    context 'entity is a string' do
      let(:entity) { 'any string' }

      it 'parses number' do
        expect(parser_call).to eq :string
      end
    end

    context 'entity is a true' do
      let(:entity) { true }

      it 'parses number' do
        expect(parser_call).to eq :boolean
      end
    end

    context 'entity is a false' do
      let(:entity) { false }

      it 'parses number' do
        expect(parser_call).to eq :boolean
      end
    end

    context 'entity is a nil' do
      let(:entity) { nil }

      it 'parses number' do
        expect(parser_call).to eq :null
      end
    end

    context 'entity is an array' do
      let(:entity) { [1, 'string', true] }

      it 'parses number' do
        expect(parser_call).to eq %i[number string boolean]
      end
    end

    context 'entity is a hash' do
      let(:entity) { { k1: true, k2: { k3: ['string', 123] }, k4: 0.1 } }

      it 'parses number' do
        expect(parser_call).to eq({ k1: :boolean, k2: { k3: %i[string number] }, k4: :number })
      end
    end
  end
end
