Class.class_eval do

  define_method :stub_any_instance do |stubs|
    unstubbed_new = method(:new)
    stub(:new).and_return do |*args|
      unstubbed_new.call(*args).tap do |obj|
        obj.stub stubs
      end
    end
    stubs
  end

end
