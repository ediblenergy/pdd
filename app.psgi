use strictures 1;
use Plack::Builder;
use FindBin;
use lib "$FindBin::Bin/lib";
use pdd::Web;
builder {
    pdd::Web->psgi_app(@_);
};
