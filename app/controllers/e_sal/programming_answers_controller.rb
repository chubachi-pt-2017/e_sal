class ESal::ProgrammingAnswersController < ESal::Base
  before_action :find_programming
  before_action :set_programming_answer, only: [:show, :edit, :update]
  before_action :set_status, only: [:create, :update]

  def show
    unless ProgrammingAnswer.has_answered?(current_user.id, @programming.id)
      respond_to do |format|
        format.html {redirect_to e_sal_programming_path(@programming.id), alert: "回答済みの場合のみ他の人の回答を閲覧できます"}
      end
      return
    end
    
    @user = User.find_by(id: @programming_answer.user_id)
  end

  def new
    @programming_answer = @programming.programming_answers.new
  end

  def create

    @programming_answer = @programming.programming_answers.new(programming_answer_params)
    
    @programming_answer.user_id = current_user.id
    
    if params[:draft]
      status = 'draft'
    else
      status = 'answered'
    end
    @programming_answer.answer_status = status
    
    respond_to do |format|
      if @programming_answer.save
        @programming_answer.create_activity :create, owner: current_user, params: {
          link_url: e_sal_programming_programming_answer_path(@programming_answer.programming_id, @programming_answer.id),
          title: @programming.title} if params[:answered]
        format.html {redirect_to e_sal_programmings_path({status: status}), notice: "保存が完了しました"}
      else
        format.html {render :new}
      end
    end
  end

  def edit
    unless chk_current_user
      respond_to do |format|
        format.html {redirect_to e_sal_programmings_path, alert: "他の人の回答は編集できません"}
      end
      return
    end
  end

  def update

    @programming_answer.attributes = programming_answer_params

    if params[:draft]
      status = 'draft'
    else
      status = 'answered'
    end
    @programming_answer.answer_status = status

    respond_to do |format|
      if @programming_answer.save
        @programming_answer.create_activity :create, owner: current_user, params: {
          link_url: e_sal_programming_programming_answer_path(@programming_answer.programming_id, @programming_answer.id),
          title: @programming.title} if params[:answered]
        format.html {redirect_to e_sal_programming_programming_answer_path, notice: "保存が完了しました"}
      else
        format.html {render :edit}
      end
    end
  end

  # get list others
  def list
    
    unless ProgrammingAnswer.has_answered?(current_user.id, @programming.id)
      respond_to do |format|
        format.html {redirect_to e_sal_programming_path(@programming.id), alert: "回答済みの場合のみ他の人の回答を閲覧できます"}
      end
      return
    end
    
    @programming_answers = ProgrammingAnswer.others(current_user.id, @programming.id).page(params[:page]).per(LIST_NUM_PER_PAGE)
    
  end
  
  def submit
    
    require 'systemu'
    
    lang_map = {"perl": "pl", "php": "php", "python": "py", "ruby": "rb"}
    
    chk_dir = Rails.root.join("tmp", "programming", "submit")

    unless chk_dir.exist?
      system("mkdir -p #{chk_dir.to_s}")
    end

    submit_dir = chk_dir.to_s

    lang = params[:lang]
    code = params[:code]
    f_time = Time.zone.now.strftime("%Y%m%d%H%S%M%L")
    
    file_name = "#{submit_dir}/#{f_time}.#{lang_map[lang.to_sym]}"
    
    File.open(file_name, "w") do |file|
      file.puts("# -*- coding: utf-8 -*-") if lang == "python"
      file.puts(code)
    end

    command = "#{lang} #{file_name}"
    
    out = ""
    err = ""

    systemu command, out: out, err: err
    
    unless err == ""
      out = err
      out = out.gsub(file_name, "")
    end
    
    data = {stdout: out}
    
    File.delete(file_name)
    
    respond_to do |format|
      format.json {render json: data}
    end
  end
  
  private
  
  def chk_current_user
    @programming_answer.user_id == current_user.id
  end
  
  def find_programming
    @programming = Programming.find(params[:programming_id])
  end
  
  def programming_answer_params
    params.require(:programming_answer).permit(:programming_language, :tab_size, :answer_code,
                  :answer_result, :answer_status, :programming_id)
  end
  
  def set_programming_answer
    @programming_answer = @programming.programming_answers.find_by(id: params[:id])
  end
  
  def set_status
    params[:programming_answer][:answer_status] = ProgrammingAnswer.answer_statuses[params[:programming_answer][:answer_status]]
  end
  
end
