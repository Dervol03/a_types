shared_examples_for 'a delegating wrapper' do
  it 'it delegates any method of the wrapped object' do
    obj = Object.new
    expect(obj).to receive(:native_method)

    wrapped_obj = described_class.new(obj)
    wrapped_obj.native_method
  end
end
