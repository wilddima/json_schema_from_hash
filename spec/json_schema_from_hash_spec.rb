# frozen_string_literal: true

RSpec.describe JsonSchemaFromHash do
  let(:build_schema) { described_class.build_schema(entity) }

  context 'entity is obfuscated_data' do
    let(:entity) do
      [{ 'value' => [], 'question_id' => 213, 'section_copy_uuid' => nil },
       { 'value' => 'sdasdas', 'question_id' => 23, 'section_copy_uuid' => nil }]
    end

    it 'return correct data' do
      expect(build_schema).to eq(
        { type: :array,
          items: { oneOf: [{ type: :object,
                             properties: { value: { type: :array, items: [] },
                                           question_id: { type: :number },
                                           section_copy_uuid: { type: :null } } },
                           { type: :object,
                             properties: { value: { type: :string },
                                           question_id: { type: :number },
                                           section_copy_uuid: { type: :null } } }] } }
      )
    end
  end

  context 'entity is obfuscated_data' do
    let(:entity) do
      {
        "fruits": %w[apple orange pear],
        "vegetables": [
          {
            "veggieName": 'potato',
            "veggieLike": true
          },
          {
            "veggieName": 'broccoli',
            "veggieLike": false
          }
        ]
      }
    end

    it 'return correct data' do
      expect(build_schema).to eq(
        { type: :object,
          properties: { fruits: { type: :array, items: [{ type: :string }] },
                        vegetables: { type: :array,
                                      items: [{ type: :object,
                                                properties: { veggieName: { type: :string },
                                                              veggieLike: { type: :boolean } } }] } } }
      )
    end
  end
end
