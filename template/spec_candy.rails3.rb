Object.class_eval do

  def should_receive_chain(*parts)
    setup_expectation_chain(parts)
  end

  def should_not_receive_chain(*parts)
    setup_expectation_chain(parts, :negate => true)
  end

  def self.new_with_stubs(attrs)
    new.tap { |obj| obj.stub(attrs) }
  end

  def should_receive_and_return(methods_and_values)
    methods_and_values.each do |method, value|
      should_receive(method).and_return(value)
    end
  end

  def self.new_and_store(options = {})
    new.tap do |record|
      record.send(:attributes=, options, false)
      record.save!(:validate => false)
    end
  end

  def stub_existing(attrs)
    attrs.each do |method, value|
      if respond_to?(method, true)
        stub(method => value)
      else
        raise "Attempted to stub non-existing method ##{method} on a #{self.class.name}"
      end
    end
  end
  
  def should_receive_and_execute(method, negate = false)
    method_base = method.to_s.gsub(/([\?\!\=\[\]]+)$/, '')
    method_suffix = $1

    method_called = "_#{method_base}_called#{method_suffix}"
    method_with_spy = "#{method_base}_with_spy#{method_suffix}"
    method_without_spy = "#{method_base}_without_spy#{method_suffix}"

    prototype = respond_to?(:singleton_class) ? singleton_class : metaclass
    prototype.class_eval do

      unless method_defined?(method_with_spy)

        define_method method_called do
        end

        define_method method_with_spy do |*args, &block|
          send(method_called, *args)
          send(method_without_spy, *args, &block)
        end
        alias_method_chain method, :spy
      end

    end

    expectation = negate ? :should_not_receive : :should_receive
    send(expectation, method_called)
  end

  private

  def setup_expectation_chain(parts, options = {})
    obj = self
    for part in parts
      if part == parts.last
        expectation = options[:negate] ? :should_not_receive : :should_receive
        obj = add_expectation_chain_link(obj, expectation, part)
      else
        next_obj = RSpec::Mocks::Mock.new('chain link')
        add_expectation_chain_link(obj, :stub, part).and_return(next_obj)
        obj = next_obj
      end
    end
    obj
  end

  def add_expectation_chain_link(obj, expectation, part)
    if part.is_a?(Array)
      obj.send(expectation, part.first).with(*part[1..-1])
    else
      obj.send(expectation, part)
    end
  end

end

RSpec::Core::ExampleGroup.class_eval do

  def self.it_should_run_callbacks_in_order(*callbacks)
    callbacks.push(:ordered => true)
    it_should_run_callbacks(*callbacks)
  end


  # Improves it_should_behave_like in some ways:
  # - It scopes the reused examples so #let und #subject does not bleed into the reusing example groups
  # - It allows to parametrize the reused example group by appending a hash argument.
  #   Every key/value pair in the hash will become a #let variable for the reused example group
  # - You can call it with a block. It will be available to the reused example group as let(:block)
  def self.it_should_act_like(shared_example_group, environment = {}, &block)
    description = "as #{shared_example_group}"
    description << " (#{environment.inspect})" if environment.present?
    describe description do
      environment.each do |name, value|
        let(name) { value }
      end
      let(:block) { block } if block
      it_should_behave_like(shared_example_group)
    end
  end

  def self.it_should_run_callbacks(*callbacks)
    options = callbacks.last.is_a?(Hash) ? callbacks.pop : {}
    reason = callbacks.pop if callbacks.last.is_a?(String)
    example_description = description
    send(:it, ["should run callbacks", callbacks.inspect, ('in order' if options[:ordered]), reason].compact.join(' ')) do
      # Set expectations
      callbacks.each do |callback|
        expectation = subject.should_receive(callback).once
        expectation.ordered if options[:ordered]
      end
      run_state_machine_callbacks_from_prose(example_description) || run_active_record_callbacks_from_prose(example_description)
    end
  end

  def run_active_record_callbacks_from_prose(prose)
    hook = prose.split.last.sub(/^#/, '')
    if hook.sub!(/_on_(create|update)$/, '')
      condition = "validation_context == :#{$1}"
    else
      condition = nil
    end
    if hook == 'validate'
      kind = 'before'
      action = 'validate'
    else
      hook =~ /^(before|after|around)_(.*)$/
      kind = $1
      action = $2
    end
    # Run all matching callbacks
    subject.send("_#{action}_callbacks").each do |callback|
      if callback.kind.to_s == kind && (condition.nil? || callback.options[:if].include?(condition))
        subject.send callback.filter.to_s.gsub(/[\(,\)]/, '').to_sym
      end
    end
  end

  def run_state_machine_callbacks_from_prose(prose)
    if parts = prose.match(/^(\#\w+) from ([\:\w]+) to ([\:\w]+)$/)
      name = parts[1].sub(/^#/, '').to_sym
      from = parts[2].sub(/^:/, '').to_sym
      to = parts[3].sub(/^:/, '').to_sym
      transition = StateMachine::Transition.new(subject, subject.class.state_machine, name, from, to)
      transition.run_callbacks
    end
  end

end

ActiveRecord::Base.class_eval do

  # Prevents the databse from being touched, but still runs all validations.
  def keep_invalid!
    errors.stub :empty? => false
  end

end
