class LearningResourcesSerializer
    include JSONAPI::Serializer
    set_id { 'null' }

    attribute :country do |object|
        object[:country]
    end

    attribute :video do |object|
        object[:video]
    end

    attribute :images do |object|
        object[:images]
    end
end