{\rtf1\ansi\deff0{\fonttbl{\f0\fnil\fcharset0 NimbusMonL-Regu;}{\f1\fnil\fcharset0 Courier New;}}
{\*\generator Msftedit 5.41.15.1515;}\viewkind4\uc1\pard\lang1031\f0\fs18 # Ruby on Rails Tutorial: first application\par
This is the first application for\par
[*Ruby on Rails xyz*]\par
by [xyz]\par
\par
==\f1\fs20  Welcome to Rails\par
\par
Rails is a web-application framework that includes everything needed to create \par
database-backed web applications according to the Model-View-Control pattern. \par
\par
This pattern splits the view (also called the presentation) into "dumb" templates\par
that are primarily responsible for inserting pre-built data in between HTML tags.\par
The model contains the "smart" domain objects (such as Account, Product, Person,\par
Post) that holds all the business logic and knows how to persist themselves to\par
a database. The controller handles the incoming requests (such as Save New Account,\par
Update Product, Show Post) by manipulating the model and directing data to the view.\par
\par
In Rails, the model is handled by what's called an object-relational mapping\par
layer entitled Active Record. This layer allows you to present the data from\par
database rows as objects and embellish these data objects with business logic\par
methods. You can read more about Active Record in\par
link:files/vendor/rails/activerecord/README.html.\par
\par
The controller and view are handled by the Action Pack, which handles both\par
layers by its two parts: Action View and Action Controller. These two layers\par
are bundled in a single package due to their heavy interdependence. This is\par
unlike the relationship between the Active Record and Action Pack that is much\par
more separate. Each of these packages can be used independently outside of\par
Rails.  You can read more about Action Pack in\par
link:files/vendor/rails/actionpack/README.html.\par
\par
\par
== Getting Started\par
\par
1. At the command prompt, start a new Rails application using the <tt>rails</tt> command\par
   and your application name. Ex: rails myapp\par
2. Change directory into myapp and start the web server: <tt>script/server</tt> (run with --help for options)\par
3. Go to http://localhost:3000/ and get "Welcome aboard: You're riding the Rails!"\par
4. Follow the guidelines to start developing your application\par
\par
\par
== Web Servers\par
\par
By default, Rails will try to use Mongrel if it's are installed when started with script/server, otherwise Rails will use WEBrick, the webserver that ships with Ruby. But you can also use Rails\par
with a variety of other web servers.\par
\par
Mongrel is a Ruby-based webserver with a C component (which requires compilation) that is\par
suitable for development and deployment of Rails applications. If you have Ruby Gems installed,\par
getting up and running with mongrel is as easy as: <tt>gem install mongrel</tt>.\par
More info at: http://mongrel.rubyforge.org\par
\par
Say other Ruby web servers like Thin and Ebb or regular web servers like Apache or LiteSpeed or\par
Lighttpd or IIS. The Ruby web servers are run through Rack and the latter can either be setup to use\par
FCGI or proxy to a pack of Mongrels/Thin/Ebb servers.\par
\par
== Apache .htaccess example for FCGI/CGI\par
\par
# General Apache options\par
AddHandler fastcgi-script .fcgi\par
AddHandler cgi-script .cgi\par
Options +FollowSymLinks +ExecCGI\par
\par
# If you don't want Rails to look in certain directories,\par
# use the following rewrite rules so that Apache won't rewrite certain requests\par
# \par
# Example:\par
#   RewriteCond %\{REQUEST_URI\} ^/notrails.*\par
#   RewriteRule .* - [L]\par
\par
# Redirect all requests not available on the filesystem to Rails\par
# By default the cgi dispatcher is used which is very slow\par
# \par
# For better performance replace the dispatcher with the fastcgi one\par
#\par
# Example:\par
#   RewriteRule ^(.*)$ dispatch.fcgi [QSA,L]\par
RewriteEngine On\par
\par
# If your Rails application is accessed via an Alias directive,\par
# then you MUST also set the RewriteBase in this htaccess file.\par
#\par
# Example:\par
#   Alias /myrailsapp /path/to/myrailsapp/public\par
#   RewriteBase /myrailsapp\par
\par
RewriteRule ^$ index.html [QSA]\par
RewriteRule ^([^.]+)$ $1.html [QSA]\par
RewriteCond %\{REQUEST_FILENAME\} !-f\par
RewriteRule ^(.*)$ dispatch.cgi [QSA,L]\par
\par
# In case Rails experiences terminal errors\par
# Instead of displaying this message you can supply a file here which will be rendered instead\par
# \par
# Example:\par
#   ErrorDocument 500 /500.html\par
\par
ErrorDocument 500 "<h2>Application error</h2>Rails application failed to start properly"\par
\par
\par
== Debugging Rails\par
\par
Sometimes your application goes wrong.  Fortunately there are a lot of tools that\par
will help you debug it and get it back on the rails.\par
\par
First area to check is the application log files.  Have "tail -f" commands running\par
on the server.log and development.log. Rails will automatically display debugging\par
and runtime information to these files. Debugging info will also be shown in the\par
browser on requests from 127.0.0.1.\par
\par
You can also log your own messages directly into the log file from your code using\par
the Ruby logger class from inside your controllers. Example:\par
\par
  class WeblogController < ActionController::Base\par
    def destroy\par
      @weblog = Weblog.find(params[:id])\par
      @weblog.destroy\par
      logger.info("#\{Time.now\} Destroyed Weblog ID ##\{@weblog.id\}!")\par
    end\par
  end\par
\par
The result will be a message in your log file along the lines of:\par
\par
  Mon Oct 08 14:22:29 +1000 2007 Destroyed Weblog ID #1\par
\par
More information on how to use the logger is at http://www.ruby-doc.org/core/\par
\par
Also, Ruby documentation can be found at http://www.ruby-lang.org/ including:\par
\par
* The Learning Ruby (Pickaxe) Book: http://www.ruby-doc.org/docs/ProgrammingRuby/\par
* Learn to Program: http://pine.fm/LearnToProgram/  (a beginners guide)\par
\par
These two online (and free) books will bring you up to speed on the Ruby language\par
and also on programming in general.\par
\par
\par
== Debugger\par
\par
Debugger support is available through the debugger command when you start your Mongrel or\par
Webrick server with --debugger. This means that you can break out of execution at any point\par
in the code, investigate and change the model, AND then resume execution! \par
You need to install ruby-debug to run the server in debugging mode. With gems, use 'gem install ruby-debug'\par
Example:\par
\par
  class WeblogController < ActionController::Base\par
    def index\par
      @posts = Post.find(:all)\par
      debugger\par
    end\par
  end\par
\par
So the controller will accept the action, run the first line, then present you\par
with a IRB prompt in the server window. Here you can do things like:\par
\par
  >> @posts.inspect\par
  => "[#<Post:0x14a6be8 @attributes=\{\\"title\\"=>nil, \\"body\\"=>nil, \\"id\\"=>\\"1\\"\}>,\par
       #<Post:0x14a6620 @attributes=\{\\"title\\"=>\\"Rails you know!\\", \\"body\\"=>\\"Only ten..\\", \\"id\\"=>\\"2\\"\}>]"\par
  >> @posts.first.title = "hello from a debugger"\par
  => "hello from a debugger"\par
\par
...and even better is that you can examine how your runtime objects actually work:\par
\par
  >> f = @posts.first\par
  => #<Post:0x13630c4 @attributes=\{"title"=>nil, "body"=>nil, "id"=>"1"\}>\par
  >> f.\par
  Display all 152 possibilities? (y or n)\par
\par
Finally, when you're ready to resume execution, you enter "cont"\par
\par
\par
== Console\par
\par
You can interact with the domain model by starting the console through <tt>script/console</tt>.\par
Here you'll have all parts of the application configured, just like it is when the\par
application is running. You can inspect domain models, change values, and save to the\par
database. Starting the script without arguments will launch it in the development environment.\par
Passing an argument will specify a different environment, like <tt>script/console production</tt>.\par
\par
To reload your controllers and models after launching the console run <tt>reload!</tt>\par
\par
== dbconsole\par
\par
You can go to the command line of your database directly through <tt>script/dbconsole</tt>.\par
You would be connected to the database with the credentials defined in database.yml.\par
Starting the script without arguments will connect you to the development database. Passing an\par
argument will connect you to a different database, like <tt>script/dbconsole production</tt>.\par
Currently works for mysql, postgresql and sqlite.\par
\par
== Description of Contents\par
\par
app\par
  Holds all the code that's specific to this particular application.\par
\par
app/controllers\par
  Holds controllers that should be named like weblogs_controller.rb for\par
  automated URL mapping. All controllers should descend from ApplicationController\par
  which itself descends from ActionController::Base.\par
\par
app/models\par
  Holds models that should be named like post.rb.\par
  Most models will descend from ActiveRecord::Base.\par
\par
app/views\par
  Holds the template files for the view that should be named like\par
  weblogs/index.html.erb for the WeblogsController#index action. All views use eRuby\par
  syntax.\par
\par
app/views/layouts\par
  Holds the template files for layouts to be used with views. This models the common\par
  header/footer method of wrapping views. In your views, define a layout using the\par
  <tt>layout :default</tt> and create a file named default.html.erb. Inside default.html.erb,\par
  call <% yield %> to render the view using this layout.\par
\par
app/helpers\par
  Holds view helpers that should be named like weblogs_helper.rb. These are generated\par
  for you automatically when using script/generate for controllers. Helpers can be used to\par
  wrap functionality for your views into methods.\par
\par
config\par
  Configuration files for the Rails environment, the routing map, the database, and other dependencies.\par
\par
db\par
  Contains the database schema in schema.rb.  db/migrate contains all\par
  the sequence of Migrations for your schema.\par
\par
doc\par
  This directory is where your application documentation will be stored when generated\par
  using <tt>rake doc:app</tt>\par
\par
lib\par
  Application specific libraries. Basically, any kind of custom code that doesn't\par
  belong under controllers, models, or helpers. This directory is in the load path.\par
\par
public\par
  The directory available for the web server. Contains subdirectories for images, stylesheets,\par
  and javascripts. Also contains the dispatchers and the default HTML files. This should be\par
  set as the DOCUMENT_ROOT of your web server.\par
\par
script\par
  Helper scripts for automation and generation.\par
\par
test\par
  Unit and functional tests along with fixtures. When using the script/generate scripts, template\par
  test files will be generated for you and placed in this directory.\par
\par
vendor\par
  External libraries that the application depends on. Also includes the plugins subdirectory.\par
  If the app has frozen rails, those gems also go here, under vendor/rails/.\par
  This directory is in the load path.\par
\par
}
 