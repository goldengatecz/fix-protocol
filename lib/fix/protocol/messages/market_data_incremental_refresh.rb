require 'fix/protocol/messages/md_entry'

module Fix
  module Protocol
    module Messages
      #
      # A full market refresh
      #
      class MarketDataIncrementalRefresh < Message
        unordered :body do
          # common fields
          field :app_ver_id,      tag: 1128
          field :sender_comp_id,  tag: 49,    required: true
          field :target_comp_id,  tag: 56,    required: true
          field :msg_seq_num,     tag: 34,    required: true, type: :integer
          field :sending_time,    tag: 52,    required: true, type: :timestamp, default: proc { Time.now.utc }

          field :md_req_id, tag: 262, required: true
          collection :md_entries, counter_tag: 268, klass: FP::Messages::MdEntry
        end
      end
    end
  end
end
