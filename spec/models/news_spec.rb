require 'spec_helper'

describe News do
  it { should validate_presence_of(:title) }
  it { should ensure_length_of(:title).is_at_least(5) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:published_at) }

  it 'should be ordered by published date' do
    second_news = FactoryGirl.create(:news, published_at: 2.day.ago)
    first_news  = FactoryGirl.create(:news, published_at: 1.second.ago)

    News.all.should == [first_news, second_news]
  end

  it '#published scope should not return news in future' do
    first_news  = FactoryGirl.create(:news, published_at: 1.day.ago)
    future_news  = FactoryGirl.create(:news, published_at: 1.day.from_now)

    News.published.should == [first_news]
  end

  it 'should have current date time has default published date' do
    News.new.published_at.should_not be_nil
  end
end
