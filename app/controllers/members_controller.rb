class MembersController < ApplicationController
  before_action :set_member, only: %i[ show edit update destroy ]
  before_action :set_user

  # GET /members or /members.json
  def index
    @members = Member.where(:user_id => @user.id)
  end

  # GET /members/1 or /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members or /members.json
  def create
    # puts "\n========\nmember_params[:user_guid].permitted?: #{member_params[:user_guid].permitted?}\n========\n"
    puts "\n========\nmember_params: #{member_params}\n========\n"
    puts "\n========\nmember_params.class: #{member_params.class}\n========\n"
    puts "\n========\ncreate_member_options: #{MXPlatformRuby::Member.send(:create_member_options, member_params)}\n========\n"
    mx_member = MXPlatformRuby::Member.create_member(member_params)
    local_member_params = {}
    local_member_params[:guid] = mx_member.guid
    local_member_params[:institution_code] = mx_member.institution_code
    local_member_params[:mx_id] = mx_member.id
    local_member_params[:name] = mx_member.name
    local_member_params[:user_id] = @user.id

    @member = Member.new(local_member_params)
    respond_to do |format|
      if @member.save
        format.html { redirect_to user_member_path(@user, @member), notice: "Member was successfully created." }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1 or /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: "Member was successfully updated." }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1 or /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: "Member was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    # Only allow a list of trusted parameters through.
    def member_params
      member_params = params.fetch(:member, {}).permit(
        :credential_a_guid,
        :credential_a_value,
        :credential_b_guid,
        :credential_b_value,
        :mx_id,
        :institution_code,
        :user_id
      )
      member_params[:credentials] = [
        {
          :guid => member_params[:credential_a_guid],
          :value => member_params[:credential_a_value]
        },
        {
          :guid => member_params[:credential_b_guid],
          :value => member_params[:credential_b_value]
        }
      ]
      # member_params.permit(:credentials => [:guid, :value])
      # member_params[:id] = member_params[:mx_id]
      member_params[:user_guid] = user_guid
      # member_params[:user_id] = params[:user_id]
      # Workaround for permission problems with credentials.
      # TODO: figure out proper way to permission credentials field and not use .to_h
      member_params.to_h
    end

    def user_guid
      User.find(params[:user_id]).guid
    end
end
