use strictures 1;
use FindBin;
use lib "$FindBin::Bin/../lib";
use WebService::Google::Reader;
use Net::OAuth2::AccessToken;

use Pdd::Auth::Google;
use Pdd::Config;
use Pdd::Schema;
use Pdd::Log qw[ :dlog ];
use Encode;
use DateTime::Format::Atom;

my $utf8 = Encode::find_encoding("UTF-8");

my $cfg = Pdd::Config->config;


my $schema = Pdd::Schema->connect( $cfg->{db} );


my $auth = Pdd::Auth::Google->new(
    scope => [
        qw(
          http://www.google.com/reader/api
          http://www.google.com/reader/atom
          )
    ],
);

sub _fetch_feed {
    my $google_reader_account = shift;

    my $guard = $google_reader_account->txn_scope_guard;

    my $user_links = $google_reader_account->user_links;

    my $access_token = $auth->restore_access_token(
        access_token_args => { $google_reader_account->get_inflated_columns } );
    $access_token->refresh;
    my $params = $access_token->session_freeze ;
    Dlog_debug { "access_toke: $_" } $params;
    $google_reader_account->update_access_token($params);
    my $reader = WebService::Google::Reader->new(
        access_token => $access_token,
        https        => 1,
        compress     => 0,
    );

    my $feed = $reader->state( 'starred', count => 50 );
    do {
        my @entries = $feed->entries;
        for my $entry (@entries) {
            my $link  = $utf8->encode( $entry->link->href );
            my $title = $utf8->encode( $entry->title );
            my $published =
              DateTime::Format::Atom->parse_datetime( $entry->published );
            $user_links->find( { link => $link } )
              or $user_links->create(
                {
                    link        => $link,
                    title       => $title,
                    create_date => $published,
                }
              );
        }
        
    } while($reader->more($feed));
    $guard->commit;
}
_fetch_feed($_) for $schema->resultset("Account::GoogleReader")->all;
