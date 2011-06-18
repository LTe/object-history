class TrackedObject
  attr_accessor :number, :track_object

  def initialize(child = nil)
    @number = 0
    @track_object = child
  end

  def add_one(*args, &block)
    @number += 1
    block.call(self) if block_given?
  end

  include ObjectHistory
  track_history_of :add_one
end
