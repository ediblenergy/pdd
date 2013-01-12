use strictures 1;
use FindBin;
use lib "$FindBin::Bin/../lib";
use LWP::UserAgent;
use pdd::Schema;
use pdd::Config;
use IO::All -encoding => "UTF-8";
use XML::Feed;
use Encode;
my $encoding = Encode::find_encoding("UTF-8");
my $ua = LWP::UserAgent->new;

my $local_path = "$FindBin::Bin/../share/starred.xml";

my $config = pdd::Config->config;

my $schema = pdd::Schema->connect( $config->{db} );

my $rs = $schema->resultset("Bookmark");

my $url = $config->{external_resources}{google_reader}{url};
my $http_response = $ua->mirror( $url, "$local_path");

my $content = io->file($local_path)->all; #decoded to perl wide string
my $feed = XML::Feed->parse( ( \$content ) );
my $new_entries = 0;
my $guard = $schema->storage->txn_scope_guard;
for my $entry ($feed->entries) {
    my $link = $encoding->encode($entry->link);
    my $title = $encoding->encode( $entry->title );
    unless ( $rs->find( { link => $link } ) ) {
        $rs->create(
            {
                link  => $link,
                title => $title,
            }
        );
        $new_entries++;
    }
}
$guard->commit;
warn "$new_entries new entries";
