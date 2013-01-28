use FindBin;
use lib "$FindBin::Bin/../lib", "$FindBin::Bin/lib";
use TestBoilerPlate;
use Pdd::Schema::Populate;


use Test::DBIx::Class {
    schema_class=>'Pdd::Schema',
     traits => [qw( Testpostgresql )],
     connect_opts => { quote_names => 1, quote_table_names => 1 },
  };

use Catalyst::Test 'Pdd::Web';
Pdd::Web->model("Pdd")->schema(Schema);

ok my $populator =
  Pdd::Schema::Populate->new(
       additional_fixtures => ["$FindBin::Bin/../etc/test.fixtures/user.yml"] ,
       schema => Schema,
   ), 'instantiate populator with test.fixtures/user.yml';
ok $populator->run, 'run Populate';
my($res, $ctx) = ctx_request('/user/1');
ok $res->is_success;

1;
