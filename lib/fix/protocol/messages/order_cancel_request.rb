module Fix
  module Protocol
    module Messages
      class OrderCancelRequest < Message
        unordered :body do
          # common fields
          field :app_ver_id,     tag: 1128
          field :sender_comp_id, tag: 49,   required: true
          field :target_comp_id, tag: 56,   required: true
          field :msg_seq_num,    tag: 34,   required: true, type: :integer
          field :sending_time,   tag: 52,   required: true, type: :timestamp, default: proc { Time.now.utc }

          field :sender_sub_id,      tag: 50
          field :deliver_to_comp_id, tag: 128
          field :cl_ord_id,          tag: 11, required: true
          field :orig_cl_ord_id,     tag: 41, required: true
          field :side,               tag: 54, required: true
          field :symbol,             tag: 55, required: true
          field :transact_time,      tag: 60, required: true, type: :timestamp, default: proc { Time.now.utc }
          field :product,            tag: 460, required: true, type: :integer, default: 4
        end
      end
    end
  end
end
