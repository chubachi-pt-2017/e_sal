class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  def new
    super
  end

  # POST /resource/confirmation
  def create
    super
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.find_by(confirmation_token: params[:confirmation_token])
    super if resource.nil? || resource.confirmed?
  end

  # PATCH /resource/confirmation
  def confirm
    confirmation_token = params[resource_name][:confirmation_token]

    @user = User.find_by(confirmation_token: confirmation_token)
    @user.attributes = confirmation_params
    
    if params[:commit] == "戻る"
      render :show
      return
    end
    
    unless @user.valid?
      render :show
      return
    end
    
    if params[:commit] == "登録する"
      if @user.save
        redirect_to users_confirmation_complete_path
      else
        render :show
      end
    elsif params[:commit] == "確認する"
      render :confirm
    end
  end
  
  def edit
    @user = User.find(current_user.id)
    if @user.nil?
      redirect_to new_user_registration_path
      return
    end
  end
  
  def update
    @user = User.find(current_user.id)

    params[:user][:confirmed] = false if params[:commit] == "back"
    @user.attributes = confirmation_params
    if @user.save(context: :profile)
      redirect_to e_sal_path
    else
      render action: 'edit'
    end
  end
  
  def complete
  end

  protected

  # The path used after resending confirmation instructions.
  def after_resending_confirmation_instructions_path_for(resource_name)
    super(resource_name)
  end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    super(resource_name, resource)
  end
  
  def confirmation_params
    params.require(resource_name).permit(
      :email,
      :confirmation_token,
      :confirmed_at,
      :password,
      :password_confirmation,
      :student_id,
      :student_id_confirmation,
      :user_name,
      :second_email,
      :course_type,
      :age,
      :gender,
      :job,
      :job_desc,
      :term_flg,
      :confirmed
    )
  end
end
