require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:notification) { FactoryBot.create(:notification, :like) }
  
  before do
    notification
  end
  
  it 'visitor_id,visited_id,action,checkedがあれば有効な状態であること' do
    notification.valid?
    expect(notification).to be_valid
  end
  
  it 'visitor_idがない場合無効な状態であること'do
    notification.visitor_id= nil
    notification.valid?
    expect(notification.errors[:visitor_id]).to include('を入力してください')
  end
  
  it 'visited_idがない場合無効な状態であること'do
    notification.visited_id= nil
    notification.valid?
    expect(notification.errors[:visited_id]).to include('を入力してください')
  end
  
  it 'actionがない場合無効な状態であること'do
    notification.action= nil
    notification.valid?
    expect(notification.errors[:action]).to include('を入力してください')
  end
  
  it 'actionがlike,follow,commen以外の値になっている場合無効な状態であること'do
    notification.action= "test"
    notification.valid?
    expect(notification.errors[:action]).to include('は一覧にありません')
  end
  
  it 'actionがlikeになっている場合有効な状態であること'do
    notification.action= "like"
    notification.valid?
    expect(notification).to be_valid
  end
  
  it 'actionがfollowになっている場合有効な状態であること' do
    notification.action= "follow"
    notification.valid?
    expect(notification).to be_valid
  end
  
  it 'actionがcommentになっている場合有効な状態であること' do
    notification.action= "comment"
    notification.valid?
    expect(notification).to be_valid
  end
  
  it 'checkedがture,false以外の場合無効な状態であること'do
    notification.checked= nil
    notification.valid?
    expect(notification.errors[:checked]).to include('は一覧にありません')
  end
end

