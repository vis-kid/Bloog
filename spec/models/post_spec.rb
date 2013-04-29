require 'minitest/autorun'
module ActiveModel
  module Naming; end
  module Conversion; end
end
require_relative '../spec_helper_lite'
stub_module 'ActiveModel::Conversion'
stub_module 'ActiveModel::Naming'
require_relative '../../app/models/post'

describe Post do
  before do
    @it = Post.new
  end

  it 'starts with blank attributes' do
    @it.title.must_be_nil
    @it.body.must_be_nil
  end

  it 'supports reading and writing a blog title' do
    @it.title = 'foo'
    @it.title.must_equal 'foo'
  end

  it 'supports reading and writing a blog body' do
    @it.body = 'foo'
    @it.boy.must_equal 'foo'
  end

  it 'supports reading and a blog reference' do
    blog = Object.new
    @it.blog = blog
    @it.blog.must_equal blog
  end

  it 'supports setting attributes in the iniitalizer' do
    it = Post.new(title: 'mytitle', body: 'mybody')
    it.title.must_equal 'mytitle'
    it.body.must_equal 'mybody'
  end

  describe '#publish' do

    before do
      @blog = MiniTest::Mock.new
      @it.blog = @blog
    end

    after do
      @blog.verify
    end

    it 'adds the post to the blog' do
      @blog.expect :add_entry, nil, [@it]
      @it.publish
    end

    describe 'given an invalid post' do
      before do @it.title = nil end

      it 'wont add the post to the blog' do
        dont_allow(@blog).add_entry
        @it.publish
      end

      it 'returns false' do
        refute(@it.publish)
      end
    end
  end

  describe '#picture?' do

    it 'is true when the post has a picture URL' do
      @it.image_url = 'http://example.org/foo.png'
      assert(@it.picutre?)
    end

    it 'is false when the post has no picture URL' do
      @it.image_url = ''
      refute(@it.picture?)
    end
  end
end
