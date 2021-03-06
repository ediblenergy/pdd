use strictures 1;
use Plack::Builder;
use FindBin;
use lib "$FindBin::Bin/./lib";
use Pdd::Web;
use DateTime::TimeZone;
builder {
    enable 'Plack::Middleware::ReverseProxy';
    enable "Plack::Middleware::Static",
    path => qr{^/static\/(img|js|css)/}, root => "$FindBin::Bin/../root/";
#    enable "Debug";
    Pdd::Web->psgi_app(@_);
     
};

