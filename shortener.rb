require 'sinatra'
require "sinatra/reloader" if development?
require 'active_record'
require 'pry'

configure :development, :production do
    ActiveRecord::Base.establish_connection(
       :adapter => 'sqlite3',
       :database =>  'db/dev.sqlite3.db'
     )
end

# Quick and dirty form for testing application
#
# If building a real application you should probably
# use views: 
# http://www.sinatrarb.com/intro#Views%20/%20Templates
form = <<-eos
    <form id='myForm'>
        <input type='text' name="url">
        <input type="submit" value="Shorten"> 
    </form>
    <h2>Results:</h2>
    <h3 id="display"></h3>
    <script src="jquery.js"></script>

    <script type="text/javascript">
        $(function() {
            $('#myForm').submit(function() {
            $.post('/new', $("#myForm").serialize(), function(data){
                $('#display').html(data);
                });
            return false;
            });
    });
    </script>
eos

# Models to Access the database 
# through ActiveRecord.  Define 
# associations here if need be
#
# http://guides.rubyonrails.org/association_basics.html
class Link < ActiveRecord::Base
  attr_accessible :longURL, :shortURL
end

get '/s/:id' do
    idSearch = params[:id]
    url = Link.select('longURL').find_by_id(idSearch).attributes['longURL'].to_s
    puts url
    '<script> window.location ="'+ url +'" </script>'
end

get '/' do
    form
end

post '/new' do
    # PUT CODE HERE TO CREATE NEW SHORTENED LINKS
    url = request.params['url']
    if Link.select("id").find_by_longURL(url)
        puts 'in db'

    else 
        l = Link.new longURL: url, shortURL: 'ourserver/short'
        l.save()
   # puts (Link.find_by_longURL url).inspect
    end
    id=(Link.select("id").find_by_longURL(url))
    #puts Link.all.inspect
    id = id.attributes['id'].to_s
    '<a href="http://localhost:4567/s/'+id+'">' + 'http://localhost:4567/s/' + id + ' </a>'
    # $('#display').text('hello')
end

get '/jquery.js' do
    send_file 'jquery.js'
end

####################################################
####  Implement Routes to make the specs pass ######
####################################################
