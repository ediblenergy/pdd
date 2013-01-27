use FindBin;
use lib "$FindBin::Bin/../lib", "$FindBin::Bin/lib";
use TestBoilerPlate;
plan tests => 1;
use Catalyst::Test 'Pdd::Web';
my($res, $ctx) = ctx_request('/');
ok my $zoom_wrapper = $ctx->view("HTML")->wrapper, 'get the zoom wrapper';
1;

