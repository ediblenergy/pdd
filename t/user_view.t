use FindBin;
use lib "$FindBin::Bin/../lib", "$FindBin::Bin/lib";
use TestBoilerPlate;

use Test::DBIx::Class {
    schema_class=>'Pdd::Schema',
     traits => [qw( Testpostgresql )],
     connect_opts => { quote_names => 1, quote_table_names => 1 },
  };

use Catalyst::Test 'Pdd::Web';
Pdd::Web->model("Pdd")->schema(Schema);

my($res, $ctx) = ctx_request('/');

1;
