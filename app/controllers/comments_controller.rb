# coding: utf-8
class CommentsController < ApplicationController
  inherit_resources
  actions :index, :show, :create, :destroy
  respond_to :json
  def create
    return render :text => t('require_login'), :status => 422 unless current_user
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    create!
  end
  def destroy
    @comment = Comment.find params[:id]
    return render :text => t('require_permission'), :status => 422 unless current_user and (current_user == @comment.user or current_user.admin)
    destroy!
  end
end
