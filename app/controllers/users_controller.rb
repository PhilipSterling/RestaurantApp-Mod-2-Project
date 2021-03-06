class UsersController < ApplicationController
    before_action :set_user, only: [:show, :destroy, :edit, :update]
    before_action :user_params, only: [:create]


      # if session.include? :user_id
      #       @cur_user = User.find(session[:user_id])
      #       @order = @cur_user.orders.find do |order|
      #         order.complete == false
      #   end
      #
      #   if !@order
      #       @order = Order.create(complete: false)
      #       if session.include? :user_id
      #       @cur_user.orders << @order
      #       end
      #   end

      def index
        if !logged_in?
          redirect_to login_path
        elsif session.include? :user_id
          @cur_user = current_user
          @order = current_order
        end
        @foods = Food.all
        @drinks = Drink.all
        @users = User.all
    end


    def new
     @user = User.new
    end



    def create
      @user = User.new(user_params)
      if @user.save
        log_in @user
        redirect_to user_path(@user)
      else
         @errors = @user.errors[:messages]
        render :new
      end
    end



    def show
      if logged_in?
        if current_user.id == params[:id].to_i
          @count = 1
          @orders = @user.orders
          @orders = @orders.select{|order| order.complete}
          @orders = @orders.sort.reverse
        else
          redirect_to root_path
        end
      else
        redirect_to root_path
      end
    end




    def update
      if @user.update(user_params)
        redirect_to @user
      end

    end



    def destroy
      @user.destroy
      redirect_to users_path
    end

    def analytics
      @users = User.all
      @orders = Order.all
      @orders = @orders.select{|order| order.complete == true}
      @order = current_order
      @user = current_user
      @foods = Food.all
      @drinks = Drink.all
      @most_ordered_drink = Order.most_ordered_drink
      @most_ordered_drink_amount = Order.most_ordered_drink_amount
      @most_ordered_food = Order.most_ordered_food
      @most_ordered_food_amount = Order.most_ordered_food_amount
      @average_meal_cost = Order.average_meal_price
      @fav_meal = current_user.fav_order
      @fav_foods = []
      @fav_drinks = []
      @fav_meal.foods.each do |food|
        @fav_foods << food
      end
      @fav_meal.drinks.each do |drink|
        @fav_drinks << drink
      end
    end



    private
    def set_user
     @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:age, :name, :password, :password_confirmation, :username)
    end

end
