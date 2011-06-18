require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "ObjectHistory" do

  before(:each) do
    @track_object = TrackedObject.new
  end

  it "rspec matcher should work" do
    3.times {@track_object.add_one}
    @track_object.should have_track(:number, [0,1,2,3])
  end

  it "should work with blocks" do
    3.times do
      @track_object.add_one do |track_obj|
        track_obj.number += 1
      end
    end
    @track_object.should have_track(:number, [0,2,4,6])
  end

  context "deep clone" do
    before(:each) do
      @track_object = TrackedObject.new(TrackedObject.new)
    end

    it "should work with deep clone object" do
      3.times do
        @track_object.add_one
      end

      4.times do
        @track_object.track_object.add_one
      end

      @track_object.should have_track(:number, [0,1,2,3])
      @track_object.track_object.should have_track(:number, [0,1,2,3,4])
    end
  end

  context "post" do
    before(:each) do
      @post = Post.new
    end

    it "should have [:new, :loaded, :accepted, :sent] path" do
      @post.load
      @post.accept
      @post.send_post

      @post.should have_track(:status, [:new, :loaded, :accepted, :sent])
    end
  end

  context "accessor" do
    before(:each) do
      @accessor = Accessor.new
    end

    it "should track accessor" do
      @accessor.version = 5
      @accessor.version = 10

      @accessor.should have_track(:version, [0,5,10])
    end
  end
end
