require 'spec_helper'
require 'support/some_class'

describe EasyCallbacks::Base do

  let(:instance) { SomeClass.new }

  it do
    expect_instance_for_puts_with('before_1: some_arg')
    expect_class_for_puts_with('before_2: some_arg')
    expect_instance_for_puts_with('some_method: some_arg')
    expect_instance_for_puts_with('around_1: some_arg')
    expect_class_for_puts_with('around_2: some_arg')
    expect_instance_for_puts_with('after_1: some_arg')
    expect_class_for_puts_with('after_2: some_arg')

    instance.some_method(:some_arg)
  end

  def expect_instance_for_puts_with(expected)
    expect(instance).to receive(:puts).with(expected).ordered
  end

  def expect_class_for_puts_with(expected)
    expect(SomeClass).to receive(:puts).with(expected).ordered
  end

end