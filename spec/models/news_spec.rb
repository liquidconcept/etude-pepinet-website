require 'spec_helper'

describe News do
  it { should validate_presence_of(:title) }
  it { should ensure_length_of(:title).is_at_least(5) }
  it { should validate_presence_of(:content) }

  it 'should be ordered by creation date' do
    second_news = FactoryGirl.create(:news, created_at: 1.day.ago)
    first_news  = FactoryGirl.create(:news)

    News.first.id.should be_equal(first_news.id)
  end
end
