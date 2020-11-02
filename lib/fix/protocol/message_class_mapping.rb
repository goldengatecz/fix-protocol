module Fix
  module Protocol
    #
    # Maps the FIX message type codes to message classes
    #
    module MessageClassMapping
      # The actual code <-> class mapping
      MAPPING = {
        '0' => :heartbeat,
        'A' => :logon,
        '1' => :test_request,
        '2' => :resend_request,
        '3' => :reject,
        '4' => :sequence_reset,
        '5' => :logout,
        '8' => :execution_report,
        '9' => :order_cancel_reject,
        'D' => :new_order_single,
        'F' => :order_cancel_request,
        'H' => :order_status_request,
        'V' => :market_data_request,
        'W' => :market_data_snapshot,
        'X' => :market_data_incremental_refresh,
        'j' => :business_message_reject
      }.freeze

      #
      # Returns the message class associated to a message code
      #
      # @param msg_type [Integer] The FIX message type code
      # @return [Class] The FIX message class
      #
      def self.get(msg_type)
        Messages.const_get(FP.camelcase(MAPPING[msg_type])) if MAPPING.key?(msg_type)
      end

      #
      # Returns the message code associated to a message class
      #
      # @param klass [Class] The FIX message class
      # @return [Integer] The FIX message type code
      #
      def self.reverse_get(klass)
        key = klass.name.split('::').last.gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase.to_sym
        MAPPING.find { |p| p[1] == key }[0]
      end
    end
  end
end
