class UsersController < ApplicationController
  def new
    #新規ユーザ登録ページ
    @user =User.new#フォームからcreateにデーターを渡す
  end
  
  def create
    #データーを受け取る
    #データーベースにセーブ
    #フラッシュ
    #リダイレクトホームページ
    #失敗
    #もう一度　render new
    #
  end
  
  def show
  end
  
  def edit
  end
  
  def destroy
  end
  
  def index
  end
  
  
  
  
end
