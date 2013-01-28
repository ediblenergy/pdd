use Test::More;
use strictures 1;
use Pdd::Config;
use FindBin;
ok my $cfg = Pdd::Config->config('test'), 'Config loads, doesnt explode';
is ref $cfg, 'HASH', "config is a hashref";
is $cfg->{db_copy}{dsn},$cfg->{db}{dsn}, "__VAR()__ replacement works";
ok my $fixture_cfg = Pdd::Config->config_from_file("$FindBin::Bin/../etc/test.fixtures/user.yml");

done_testing;
