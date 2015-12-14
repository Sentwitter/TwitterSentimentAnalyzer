class TweetsController < ApplicationController

  @tweets
  
  def new
    # rend le formulaire de création
  end

  def create
    # crée la donnée (déclenchée à l'envoie du formulaire)
  end

  def index
    @tweets = Tweet.not_hand_annotated.paginate(page: params[:page], per_page: 10)
  end

  def show
    # rend une donnée
  end

  def edit
    # rend le formulaire de modification
  end

  def update
    # modifie la donnée
  end

  def destroy
    # détruit la / les données
  end
end
