class AttachedFilePresenceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, "Image can't be blank") unless value.attached?
  end
end
