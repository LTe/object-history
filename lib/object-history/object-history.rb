module ObjectHistory
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def track_history_of(*methods, &block)
      attr_accessor :__history

      methods.each do |method|
        track_method = "__#{method}__track__"
        unless private_instance_methods.include?(track_method)
          alias_method track_method, method
          private track_method
          define_method method do |*args, &block|
            @__history ||= [Marshal.load(Marshal.dump(self))]
            ret = send(track_method, *args, &block)
            @__history << Marshal.load(Marshal.dump(self))
            ret
          end
        end
      end
    end
  end
end
