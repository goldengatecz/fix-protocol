module Fix
  module Protocol
    module Messages
      #
      # A FIX market data request reject message
      #
      class MarketDataRequestReject < Message
        unordered :body do
          # common fields
          field :app_ver_id,     tag: 1128
          field :sender_comp_id, tag: 49,   required: true
          field :target_comp_id, tag: 56,   required: true
          field :target_sub_id,  tag: 57
          field :msg_seq_num,    tag: 34,   required: true, type: :integer
          field :sending_time,   tag: 52,   required: true, type: :timestamp, default: proc { Time.now.utc }

          field :on_behalf_of_comp_id, tag: 115
          field :text,                 tag: 58
          field :md_req_id,            tag: 262, required: true
          field :md_req_rej_reason,    tag: 281
        end
      end
    end
  end
end
