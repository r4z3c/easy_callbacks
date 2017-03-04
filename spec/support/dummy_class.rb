class DummyClass

  def a_public_instance_method(arg)
    puts "a_public_instance_method_arg: #{arg}"
  end

  def another_public_instance_method(arg)
    puts "another_public_instance_method_arg: #{arg}"
  end

  def a_public_instance_method_with_error(arg)
    puts "a_public_instance_method_with_error_arg: #{arg}"
    raise 'some runtime error'
  end

  protected

  def a_protected_instance_method(arg)
    puts "a_protected_instance_method_arg: #{arg}"
  end

  private

  def a_private_instance_method(arg)
    puts "a_private_instance_method_arg: #{arg}"
  end

  class << self

    def a_public_singleton_method(arg)
      puts "a_public_singleton_method_arg: #{arg}"
    end

    def another_public_singleton_method(arg)
      puts "another_public_singleton_method_arg: #{arg}"
    end

    protected

    def a_protected_singleton_method(arg)
      puts "a_protected_singleton_method_arg: #{arg}"
    end

    private

    def a_private_singleton_method(arg)
      puts "a_private_singleton_method_arg: #{arg}"
    end

    include EasyCallbacks

    before :another_public_singleton_method do
      puts "before_another_public_singleton_method_with: #{call_args}"
    end

    around :another_public_singleton_method do
      puts "around_another_public_singleton_method_with: #{call_args}"
    end

    after :another_public_singleton_method do
      puts "after_another_public_singleton_method_with: #{call_args}"
    end

  end

  include EasyCallbacks

  before :another_public_instance_method do
    puts "before_another_public_instance_method_with: #{call_args}"
  end

  around :another_public_instance_method do
    puts "around_another_public_instance_method_with: #{call_args}"
  end

  after :another_public_instance_method do
    puts "after_another_public_instance_method_with: #{call_args}"
  end

end

EasyCallbacks.configure(DummyClass) do
  before :a_public_instance_method do
    puts "before_a_public_instance_method_with: #{call_args}"
  end

  around :a_public_instance_method do
    puts "around_a_public_instance_method_with: #{call_args}"
  end

  after :a_public_instance_method do
    puts "after_a_public_instance_method_with: #{call_args}"
  end

  before :a_protected_instance_method do
    puts "before_a_protected_instance_method_with: #{call_args}"
  end

  around :a_protected_instance_method do
    puts "around_a_protected_instance_method_with: #{call_args}"
  end

  after :a_protected_instance_method do
    puts "after_a_protected_instance_method_with: #{call_args}"
  end

  before :a_private_instance_method do
    puts "before_a_private_instance_method_with: #{call_args}"
  end

  around :a_private_instance_method do
    puts "around_a_private_instance_method_with: #{call_args}"
  end

  after :a_private_instance_method do
    puts "after_a_private_instance_method_with: #{call_args}"
  end

  around :a_public_instance_method_with_error do
    puts "around_a_public_instance_method_with_error: #{callback_details[:return_object]}"
  end
end

EasyCallbacks.configure(DummyClass.singleton_class) do
  before :a_public_singleton_method do
    puts "before_a_public_singleton_method_with: #{call_args}"
  end

  around :a_public_singleton_method do
    puts "around_a_public_singleton_method_with: #{call_args}"
  end

  after :a_public_singleton_method do
    puts "after_a_public_singleton_method_with: #{call_args}"
  end

  before :a_protected_singleton_method do
    puts "before_a_protected_singleton_method_with: #{call_args}"
  end

  around :a_protected_singleton_method do
    puts "around_a_protected_singleton_method_with: #{call_args}"
  end

  after :a_protected_singleton_method do
    puts "after_a_protected_singleton_method_with: #{call_args}"
  end

  before :a_private_singleton_method do
    puts "before_a_private_singleton_method_with: #{call_args}"
  end

  around :a_private_singleton_method do
    puts "around_a_private_singleton_method_with: #{call_args}"
  end

  after :a_private_singleton_method do
    puts "after_a_private_singleton_method_with: #{call_args}"
  end
end