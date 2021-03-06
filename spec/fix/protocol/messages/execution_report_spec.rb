require_relative '../../../spec_helper'

describe 'Fix::Protocol::Messages::ExecutionReport' do
  before do
    @msg = <<-MSG.gsub(/(\n|\s)+/, '').tr('|', "\x01")
      8=FIX.4.4|9=439|35=8|49=SNDCOMPID|56=TRGCOMPID|34=235|52=20161129-13:50:26.123|50=SNDSUBID|
      115=ONBHLFCOMID|6=123.45|11=CLORDID|14=1245|15=XAU|17=EXECID|18=B|31=11.10|32=500|37=ORDERID|
      38=1000|39=1|40=1|41=ORIGCLID|44=11.12|54=1|55=XAU/USD|58=SOMETEXT|59=0|
      60=20161129-13:50:26.159|64=20161129|75=20161128|103=99|110=0|119=20|120=XAU|
      126=20161130-23:59:59.999|150=1|151=49|167=FOR|168=20161129-13:50:26.123|38=0|194=11.00|
      195=0.11|460=4|541=20161130|555=0|10=111|
    MSG
  end


  context 'valid messages' do
    it 'properly parse valid message' do
      puts FP.parse(@msg).errors
      expect(FP.parse(@msg)).to be_a_kind_of(FP::Messages::ExecutionReport)
    end

    it 'after fullfilled simple order' do
      FP::Message.version = 'FIX.4.3'
      msg = Fix::Protocol.parse(fullfilled_simple_order_reply)
      expect(msg).not_to be_a_kind_of(Fix::Protocol::ParseFailure)
      FP::Message.version = 'FIX.4.4'
    end

    it 'after order status of cancelled order' do
      FP::Message.version = 'FIX.4.3'

      msg = Fix::Protocol.parse(order_status_reply)
      expect(msg).not_to be_a_kind_of(Fix::Protocol::ParseFailure)
      expect(msg.ord_status).to eq :cancelled
      FP::Message.version = 'FIX.4.4'
    end
  end


  it '#dump should return the same message' do
    expect(FP.parse(@msg).dump).to eql(@msg)
  end

  private
  def order_status_reply
    <<-MSG.gsub(/(\n|\s)+/, '').tr('|', "\x01")
      8=FIX.4.3|9=231|35=8|34=194|49=demo.fxgrid|52=20170629-11:52:13.261|56=order.ORODGC0008.001|115=|6=0|11=7858|14=0|15=XAU|17=0|31=0|37=1351422814|38=0.01|39=4|40=1|54=1|55=XAU/USD|59=0|60=20170629-09:44:57.226|150=I|151=0.01|167=FOR|460=4|790=7858|10=163|
    MSG
  end

  def fullfilled_simple_order_reply
    <<-MSG.gsub(/(\n|\s)+/, '').tr('|', "\x01")
      8=FIX.4.3|9=322|35=8|34=3|49=demo.fxgrid|50=ORO|52=20170619-08:10:15.177|56=order.ORODGC0008.001|115=ORO|6=1249.971|11=CL_ORD_ID|14=100|15=XAU|17=FXI2233932805|18=B|31=1249.971|32=100|37=1350037802|38=100|39=2|40=1|54=1|55=XAU/USD|59=0|60=20170619-08:10:15.147|64=20170621|75=20170619|110=0|119=124997.1|120=USD|150=F|151=0|167=FOR|460=4|10=231|
    MSG
  end
end
