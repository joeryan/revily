module Revily
  module Event
    class Handler
      class Incident < Handler
        abstract true
        events []

        def handle
          logger.warn "Override #handle in a subclass"
        end

        def handle?
          valid? && 
          service && 
          service.enabled? && 
          service.policy && 
          current_policy_rule?
        end

        def incident
          source
        end

        def service
          incident.service
        end

        def current_policy_rule
          incident.try(:current_policy_rule)
        end

        def current_policy_rule?
          !!current_policy_rule
        end

        def escalation_timeout
          current_policy_rule.try(:escalation_timeout) || 30
        end

        def acknowledge_timeout
          service.try(:acknowledge_timeout)
        end

        def acknowledge_timeout?
          !!acknowledge_timeout
        end

        def auto_resolve_timeout
          service.try(:auto_resolve_timeout)
        end

        def auto_resolve_timeout?
          !!auto_resolve_timeout
        end

      end
    end
  end
end
