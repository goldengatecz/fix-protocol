module Fix
  module Protocol
    module Messages
      class OrderCancelReject < Message
        ORDER_STATUS_AFTER = {
          pending_new: 'A',
          new: '0',
          partially_filled: '1',
          filled: '2',
          rejected: '8',
          expired: 'C',
          canceled: '4',
          replaced: '5'
        }.freeze

        REASONS_FOR_CANCEL = {
          too_late_to_cancel: '0',
          unknown_order:  '1',
          already_in_pending_cancel: '3',
          duplicate_clordid: '6'
        }.freeze

        RESPONSE_TO = {
          order_cancel_request: '1',
          order_replace_request: '2'
        }.freeze

        unordered :body do
          # common fields
          field :app_ver_id,      tag: 1128
          field :sender_comp_id,  tag: 49,    required: true
          field :target_comp_id,  tag: 56,    required: true
          field :msg_seq_num,     tag: 34,    required: true, type: :integer
          field :sending_time,    tag: 52,    required: true, type: :timestamp, default: proc { Time.now.utc }

          field :target_sub_id,        tag: 57
          field :on_behalf_of_comp_id, tag: 115, required: true
          field :deliver_to_comp_id,   tag: 128
          field :deliver_to_sub_id,    tag: 129
          field :cl_ord_id,            tag: 11, required: true
          field :order_id,             tag: 37, required: true
          field :ord_status,           tag: 39, required: true, mapping: ORDER_STATUS_AFTER
          field :orig_cl_ord_id,       tag: 41, required: true
          field :text,                 tag: 58
          field :cxl_rej_reason,       tag: 102, type: :integer, mapping: REASONS_FOR_CANCEL
          field :cxl_rej_response_to,  tag: 434, required: true, type: :integer, mapping: RESPONSE_TO
        end
      end
    end
  end
end
