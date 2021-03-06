require 'fog/core/model'

module Fog
  module Identity
    class OpenStack
      class V3
        class Endpoint < Fog::Model
          identity :id

          attribute :description
          attribute :interface
          attribute :service_id
          attribute :name
          attribute :region
          attribute :url
          attribute :links

          def to_s
            self.name
          end

          def destroy
            requires :id
            service.delete_endpoint(self.id)
            true
          end

          def update(attr = nil)
            requires :id
            merge_attributes(
                service.update_endpoint(self.id, attr || attributes).body['endpoint'])
            self
          end

          def save
            requires :name
            identity ? update : create
          end

          def create
            merge_attributes(
                service.create_endpoint(attributes).body['endpoint'])
            self
          end

        end
      end
    end
  end
end