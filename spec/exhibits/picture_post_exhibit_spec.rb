require_relative '../spec_helper_lite'
require_relative '../../app/exhibits/picture_post/exhibit'

describe PicturePostExhibit do
  
  before do
    @post = OpenStruct.new(
      title: "Title",
      body: "Body",
      pubdate: "Pubdate")
    @context = stub!
    @it = PicturePostExhibit.new(@post, @context)
  end

  it 'delegates method calls to the post' do
    @it.title.must_equal 'Title'
    @it.body.must_equal 'Body'
    @it.pubdate.must_equal 'Pubdate'
  end

  it 'renders itself with the appropriate partial' do
    mock(@context).render(
      partial: "/posts/picture_body", locals: { post: @it }) {
      "The_HTML"
    }
    @it.render_body.must_equal "The_HTML"
  end
end
