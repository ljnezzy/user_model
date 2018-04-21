# README

This will be used to show the steps when creating a user model.  using https://www.railstutorial.org/book/beginning as a reference.

step 1: created app user_model:
			rails new user_model

step 2: added the following gems:
		gem 'jquery-rails'
		gem 'bootstrap', '~> 4.0'
		gem 'execjs'
		gem 'annotate', '~> 2.7', '>= 2.7.1'
		gem 'listen', '>= 3.0.5', '< 3.2'
		gem 'spring'
 		gem 'spring-watcher-listen', '~> 2.0.0'
  uncommented:
  	gem 'bcrypt', '~> 3.1.7'
  commented out:
  	#gem 'capybara', '~> 2.13'
  	#gem 'selenium-webdriver'

step 3: change directory to user_model
				ran bundle install

step 4: ran rails generate controller Pages index  
	to create a controller to control the static pages of:
			index

step 5: change file config/routes.rb to show veiws/pages/index.html.erb as the root page.
		Rails.application.routes.draw do
		  root 'pages#index'
		  #get 'pages/index'
		end 
			
step 6: added:
				@import "bootstrap-sprockets";
				@import "bootstrap";
		to app/assets/applications.css

step 7: ran:
			rails g resource user name:string email:string password:digest
	to create the controller and model for a user. creates the following in the migration table:
					t.string :name
					t.string :email
					t.string :password_digest

step 8: ran  rails db:migrate 
	to migrate the database into the app.

step 9: user CRUD (Create, Read, Update and Delete)
	UsersController:

class UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
	      redirect_to @user, notice: "Thanks for signing up!"
	    else
	      render :new
	    end 
	  end

  def update
    if @user.update(user_params)
	      redirect_to @user, notice: "Account successfully updated!"
	    else
	      render :edit
	  end
  end

  def destroy
    @user.destroy
	    redirect_to users_path, alert: "Account successfully deleted!"
  end

private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

added the following files to veiws/users :
		_form.html.erb
		edit.html.erb
		index.html.erb
		show.html.erb


step 10: nav bar in views/layouts/application.html.erb :
		<nav>
  		<%= link_to 'Home', root_path %>
  		<%= link_to 'Users', users_path %>
  	</nav>

  	added buttons to links

step 11: User validations
	file models/user.rb added:
			validates :name, presence: true, length: { maximum: 50 }
			VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  		validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }


step 12: adding email index
		ran:   
				rails g migration add_index_to_users_email
		added to migration file:
				def change
				  add_index :users, :email, unique: true
				end
		ran:
				rails db:migrate
		added to models/user.rb (before validations):
				 before_save { email.downcase! }

