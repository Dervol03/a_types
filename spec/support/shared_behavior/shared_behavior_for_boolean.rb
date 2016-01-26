shared_examples_for 'a Boolean' do |obj_instance|
  it 'responds to #to_bool' do
    expect(obj_instance).to respond_to(:to_bool)
  end

  it 'responds to #to_b' do
    expect(obj_instance).to respond_to(:to_b!)
  end

  it 'responds to #to_bool!' do
    expect(obj_instance).to respond_to(:to_bool!)
  end

  it 'responds to #to_b!' do
    expect(obj_instance).to respond_to(:to_b!)
  end
end