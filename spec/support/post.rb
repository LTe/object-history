class Post
  attr_accessor :status

  def initialize
    @status = :new
  end

  def accept
    @status = :accepted
  end

  def send_post
    @status = :sent
  end

  def load
    @status = :loaded
  end

  include ObjectHistory
  track_history_of :accept, :send_post, :load
end

