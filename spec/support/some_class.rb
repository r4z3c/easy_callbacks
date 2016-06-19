class SomeClass

  def some_method(some_arg)
    puts "some_method: #{some_arg}"
  end

  include EasyCallbacks::Base

  before :some_method, :before_1
  before :some_method do |some_arg, callback_details|
    puts "before_2: #{some_arg}"
  end

  around :some_method, :around_1
  around :some_method do |some_arg, callback_details|
    puts "around_2: #{some_arg}"
  end

  after :some_method, :after_1
  after :some_method do |some_arg, callback_details|
    puts "after_2: #{some_arg}"
  end

  def before_1(some_arg, callback_details)
    puts "before_1: #{some_arg}"
  end

  def around_1(some_arg, callback_details)
    puts "around_1: #{some_arg}"
  end

  def after_1(some_arg, callback_details)
    puts "after_1: #{some_arg}"
  end

end