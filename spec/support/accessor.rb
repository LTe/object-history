class Accessor
  attr_accessor :version

  def initialize
    @version = 0
  end

  include ObjectHistory 
  track_history_of :version=
end
