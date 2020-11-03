module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    def fb_auth token:
      FirebaseIdToken::Certificates.request! unless FirebaseIdToken::Certificates.present?
      @payload = FirebaseIdToken::Signature.verify token
      raise ArgumentError, "Invalid or Missing Token" if @payload.blank?
      @payload
    end

  end
end
