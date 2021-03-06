class FriendsController < ApplicationController
  def index
  	if(current_user)
    	@friends = Friend.all
    else
    	redirect_to root_path
    end
  end

  def create
  	friend = params.require(:friend).permit(:email)
  	@amigo = User.find_by(email: friend[:email])
  	if @amigo.nil?
  		flash[:error] = "Esta pessoa não foi encontrada... Tem certeza de que digitou o e-mail corretamente?"
  		redirect_to friends_path
    elsif current_user.nil?
      flash[:error] = "Você nem existe de verdade e quer ter amigos, wtf"
      redirect_to root_url
    else
      @friend = Friend.new(sender_id: current_user.id, receiver_id: @amigo.id)
      if @friend.save
        flash[:notice] = "Seu pedido de amizade foi enviado"
        redirect_to friends_path
      else
        flash[:error] = "Deu bostaaaaaaaaaaa"
      end
    end
  end

  def new
  	@friend = Friend.new
  end

  def eat
    @friends = Friend.all
  end

  def selected
    @selec = params[:selected_ids]
    if @selec.nil?
      flash[:error] = "Você não selecionou amigos"
      redirect_to eat_path
    else
    @records = Record.all
    end
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  def add
    request = params[:request_id].to_i
    if(!request.nil?)
        pedido = Friend.find(request)
        if(pedido.receiver_id == current_user.id)
          if(pedido.nil?)
            flash[:notice] = "Para de tentar hackear os bagulhos porra"
          else
            pedido.status = true
            pedido.save
          end
        else
          flash[:notice] = "Para de tentar hackear os bagulhos porra"
        end
    else
      flash[:notice] = "Para de tentar hackear os bagulhos porra"
    end
    redirect_to friends_url
  end

  def remove
    request = params[:request_id].to_i
    if(!request.nil?)
        pedido = Friend.find(request)
        if(pedido.receiver_id == current_user.id || pedido.sender_id == current_user.id)
          if(pedido.nil?)
            flash[:notice] = "Para de tentar hackear os bagulhos porra"
          else
            pedido.destroy
          end
        else
          flash[:notice] = "Para de tentar hackear os bagulhos porra"
        end
    else
      flash[:notice] = "Para de tentar hackear os bagulhos porra"
    end
    redirect_to friends_url
  end

  private
    def friend_params
      params.require(:friend).permit(:email)
    end

end
