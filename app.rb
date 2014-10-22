require 'sinatra'
require 'slim'
require './helpers/just_eat_api'
require './models/restaurant_model'

get '/' do
  postcode = params[:postcode]
	@restaurants = JustEatApi.list(postcode)
  slim :index
end

__END__

@@ layout

doctype 5
html
  head
    title resto
    meta name="viewport" content="width=device-width, initial-scale=1.0"
    link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet"
    link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css" rel="stylesheet"

    /[if lt IE 9]
      script src="//oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"
      script src="//oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"

  body
    div class="container-fluid"

    nav class="navbar navbar-default" role="navigation"
      div class='navbar-inner'
        div class='container-fluid'
          a class="navbar-brand" href="/" JUST EAT
          form class="navbar-form" role="form"
            div class="form-group"
              label class="sr-only" for="exampleInputEmail2" Email address
              input class="form-control" name="postcode" id="exampleInputEmail2" placeholder="Postcode"
              button type="submit" class="btn btn-default" Search

    div class="container-fluid"
      == yield

    script src="//code.jquery.com/jquery-1.11.1.min.js"
    script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"


@@ index

div class="row thumbnails"
- @restaurants.take(30).each do |r|
  div class="col-xs-6 col-sm-4 col-md-3 col-lg-3 block"
    img src=r.logo_url
    h4 = r.name
    h5 = r.cuisines.join(', ')
