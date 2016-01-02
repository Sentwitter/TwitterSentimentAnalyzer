class TweetsController < ApplicationController

  @tweets
  
  def new
    # rend le formulaire de création
  end

  def create
    # crée la donnée (déclenchée à l'envoie du formulaire)
  end

  def index
    @tweets = Tweet.paginate(page: params[:page], per_page: 10)
  end

  def show
    # rend une donnée
  end

  def edit
    # rend le formulaire de modification
  end

  def update
    # modifie la donnée
    @tweet = Tweet.find(params[:id])
    @tweet.update(tweet_params.merge(hand_annotated: true))
    redirect_to(:back)
  end

  def destroy
    # détruit la / les données
  end

  def tweet_params
    params.require(:tweet).permit(:annotation)
  end
end
