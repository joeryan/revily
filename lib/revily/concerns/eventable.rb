module Revily::Concerns
  module Eventable
    extend ActiveSupport::Concern

    included do
      include Revily::Event
      has_many :events, as: :source
    end

    def eventable?
      self.class.eventable?
    end

    module ClassMethods

      def events(*args)
        @events ||= []
        return @events if args.empty?
        @events.concat(args).uniq!
      end

      def eventable?
        true
      end
    end

  end
end
