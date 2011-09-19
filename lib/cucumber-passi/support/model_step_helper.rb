require 'active_support/core_ext/hash'

# Depends: factory_girl (for rails 2.x),
#          factory_girl_rails (for rails 3.x)

# Generates a model, via FactoryGirl
# Supports (supported) associations via comma-delimited list
# Uses human_readable_identifier_columns
# Supported associations: tags, :folders
def generate_model(factory_name, model_attributes = {})
  model_attributes.stringify_keys!
  tags = model_attributes.delete('tags')
  folders = model_attributes.delete('folders')

  new_model = Factory.create(factory_name, model_attributes)

  # association columns
  unless tags.blank?
    tags.split(',').each { |tag| new_model.tags << Factory.create(:tag, :title => tag.strip) }
  end
#  unless folders.blank?
#    folders.split(',').each { |folder_name| new_model.folders << Factory.create(:folder, :folder_name => folder_name.strip) }
#  end

  return new_model
end
