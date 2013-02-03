use FindBin;
use lib "$FindBin::Bin/../lib", "$FindBin::Bin/lib";
use TestBoilerPlate;
use Pdd::JSON_API;
plan tests => 5;
ok my $json_api = Pdd::JSON_API->new, 'instantiate json_api';
ok $json_api->uri("http://googlepants.com")->isa("URI"),
  "uri object returned from ->uri";
  eval {
      $json_api->uri("/googlepants.com")->isa("URI");
  };
ok $@ =~ /base_url required/, "base_url required exception thrown";

ok $json_api= Pdd::JSON_API->new( base_url => 'http://googlepants.com' ),
  'json_api instantiated with base_url';
ok $json_api->uri("/googlepants.com")->isa("URI"), 'relative url call to uri()';
