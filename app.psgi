use strictures 1;
use Plack::Builder;
use FindBin;
use lib "$FindBin::Bin/./lib";
use pdd::Web;
builder {
    enable "Plack::Middleware::Static",
    path => qr{^/static\/(img|js|css)/}, root => "$FindBin::Bin/./root/";
#    enable "Debug";
    pdd::Web->psgi_app(@_);
     
};

