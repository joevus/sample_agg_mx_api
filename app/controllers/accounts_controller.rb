class AccountsController < ApplicationController
  before_action :set_user

  def index
    mxplatform_accounts = MXPlatformRuby::Account.list_user_accounts(account_params)
    @accounts = mxplatform_accounts
  end

private
  def account_params
    account_params = params.fetch(:account, {}).permit(
      :user_id,
      :id,
      :account_id
    )
    account_params[:user_guid] = @user.guid
    account_params
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end