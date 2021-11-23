# frozen_string_literal: true

RSpec.describe JsonSchemaFromHash::Builder do
  describe '#call' do
    let(:builder_call) { described_class.new(entity).call }

    context 'entity is a hash' do
      let(:entity) do
        { k1: :boolean, k2: { k3: %i[string number] }, k4: :number }
      end

      it 'builder correct' do
        expect(builder_call).to eq(
          { type: :object,
            properties: { k1: { type: :boolean },
                          k2: { type: :object,
                                properties: { k3: { type: :array,
                                                    items: { oneOf: [{ type: :string }, { type: :number }] } } } },
                          k4: { type: :number } } }
        )
      end
    end
  end
end
