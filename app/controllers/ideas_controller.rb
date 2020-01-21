class IdeasController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :find_idea, only: [:edit, :update, :show, :destroy]
    before_action :authorize!, only: [:edit,:update,:destroy]


    def new
        @idea=Idea.new
    end

    def create
        @idea = Idea.new idea_params
        @idea.user = current_user
        if @idea.save 
            flash[:notice] = 'idea Created Successfully'
            redirect_to ideas_path(@idea.id)
        else
            render :new
        end
    end

    def edit
        
    end

    def update
        if @idea.update idea_params
            flash[:notice] = 'idea updated Successfully'
            redirect_to idea_path(@idea.id)
        else
            render :edit
        end
    end

   
    def index 
        @ideas = Idea.order(created_at: :desc)
    end


    def show
        @new_review = Review.new
        @reviews = @idea.reviews.order(created_at: :desc)
        @like = @idea.likes.find_by(user: current_user)
    end

    def destroy
        @idea.destroy
        redirect_to ideas_path
    end

    # def liked
    #     @ideas = current_user.liked_ideas.order('likes.created_at DESC')
    # end


    private
    
    def find_idea
        @idea = Idea.find params[:id]
    end

    def idea_params
        params.require(:idea).permit(:title, :description)
    end

    def authorize! 
        unless can?(:crud, @idea)
            redirect_to root_path, alert: 'Not Authorized' 
        end
    end

end
