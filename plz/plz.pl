#!/usr/bin/env perl

use Mojolicious::Lite;
use utf8;

plugin charset => { charset => 'utf-8' };

get '/' => 'foam';

get '/search' => sub {
    my $self = shift;

    if ( $self->param('plz') =~ /^(\d{5})$/ ) {
        $self->redirect_to( 'plz', plz => $1 );
    }
    else {
        $self->flash( input => $self->param('plz') );
        $self->redirect_to('error');
    }
};

# TODO auf leere Eingabe

get '/:plz' => [ plz => qr/\d{5}/ ] => 'plz';

get '/error' => 'error';

app->start;
__DATA__

@@ foam.html.ep
% layout 'main';
<form action="search" method="get">
<p>
    <label for="plz">Gib Deine Postleitzahl ein:</label>
    <input type="text" id="plz" name="plz" size="5">
    <input type="submit" value="Suchen!">
</p>

@@ plz.html.ep
% layout 'main';
<h2>Dein nächster Nogger-Riegel-Händler!</h2>
<p><strong>Mensa in der Hüfferstiftung</strong><br>
Hüfferstraße 27<br>
48149 Münster</p>
<iframe width="750" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.de/maps?f=q&amp;source=s_q&amp;hl=de&amp;geocode=&amp;q=h%C3%BCfferstiftung&amp;sll=51.151786,10.415039&amp;sspn=15.516275,39.506836&amp;ie=UTF8&amp;hq=h%C3%BCfferstiftung&amp;hnear=&amp;ll=52.882391,8.151855&amp;spn=3.812206,9.876709&amp;z=7&amp;iwloc=A&amp;cid=16229777876802121584&amp;output=embed"></iframe><br /><small><a href="http://maps.google.de/maps?f=q&amp;source=embed&amp;hl=de&amp;geocode=&amp;q=h%C3%BCfferstiftung&amp;sll=51.151786,10.415039&amp;sspn=15.516275,39.506836&amp;ie=UTF8&amp;hq=h%C3%BCfferstiftung&amp;hnear=&amp;ll=52.882391,8.151855&amp;spn=3.812206,9.876709&amp;z=7&amp;iwloc=A&amp;cid=16229777876802121584" style="color:black;text-align:left">Größere Kartenansicht</a></small>

@@ error.html.ep
% layout 'main';
<p id="error">Sorry, '<%= flash('input') %>' ist irgendwie keine Postleitzahl.</p>
<p><a href="./">Nochmal probieren</a></p>

@@ layouts/main.html.ep
<!doctype html><html>
<head>
<title>Nogger Riegel: Händlersuche</title>
<link rel="stylesheet" href="style.css" type="text/css">
</head>
<body>
<div id="canvas">
<div id="header">
<img id="logo" src="nogger_riegel_klein.jpg" alt="" width="100" height="100">
<h1>Nogger Riegel: Händlersuche</h1>
<p>Dieses Eis ist verdammt lecker. Hol es Dir!</p>
</div>
<div id="content">
<%== content %>
</div>
</div>
<address><a href="http://twitter.com/nogger_riegel">@nogger_riegel</a></address>
</body>
</html>
