use DBIx::Class::Fixtures;
use FindBin;
use strictures 1;
use Pdd::Config;
use Pdd::Schema;
my $schema = Pdd::Schema->connect( Pdd::Config->config->{db} );
my $v = 2;
my $set = "all_tables";
my $fixtures = DBIx::Class::Fixtures->new(
    { config_dir => "$FindBin::Bin/../share/fixtures/$v/conf" } );
$fixtures->dump(
    {
        config    => "$set.json",
        schema    => $schema,
        directory => $fixtures->config_dir . "/../$set"
    }
);
1;
