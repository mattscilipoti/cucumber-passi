require 'active_support/core_ext/hash'

module Passi
  module StepHelpers
    # Depends: factory_girl (for rails 2.x),
    #          factory_girl_rails (for rails 3.x)

    # Generates a model, via FactoryGirl
    # Supports (supported) associations via comma-delimited list
    # Uses human_readable_identifier_columns
    # Supported associations: tags, :folders
    def generate_model(factory_name, model_attributes = {})
      model_attributes.stringify_keys!
      tags = model_attributes.delete('tags')
      features = model_attributes.delete('features')
      folders = model_attributes.delete('folders')

      new_model = Factory.create(factory_name, model_attributes)

      # association columns
      unless features.blank?
        features.split(',').each { |feature_title| new_model.features.create(Factory.attributes_for(:feature, :title => feature_title.strip)) }
      end
      unless folders.blank?
        folders.split(',').each { |folder_name| new_model.folders.create(Factory.attributes_for(:folder, :folder_name => folder_name.strip)) }
      end
      unless tags.blank?
        tags.split(',').each { |tag| new_model.tags.create(Factory.attributes_for(:tag, :title => tag.strip)) }
      end
      instance_variable_set("@#{new_model.class.name.underscore}", new_model)
      return new_model
    end
  end
end
