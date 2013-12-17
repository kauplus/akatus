shared_examples_for Akatus::Transferrable do

  it "can be initialized with attributes" do

    obj = described_class.new(attrs)

    attrs.each do |attr, value|
      obj.send(attr).should == value
    end

  end

  it "can be turned into a JSON payload" do

    obj = described_class.new(attrs)

    obj.to_payload.should == payload
    obj.to_payload(false).should == payload.values.first

  end

end
