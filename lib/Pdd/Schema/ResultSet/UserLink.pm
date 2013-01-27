package Pdd::Schema::ResultSet::UserLink;

use Pdd::Schema::ResultSet;
use HTML::Entities;
use URI;

sub latest_links {
    my ($self,$count)  = @_;
    my $rs =
      $self->search( undef,
                     {  order_by     => { -desc => 'create_date' },
                        result_class => "::HRI"
                     } );
    return [
        map {
            my $title = utf8_encoding()->decode( $_->{title} );
            my $link = URI->new( utf8_encoding()->decode( $_->{link} ) );

            +{  link  => "$link",
                title => decode_entities($title),
                host  => $link->host, }
        } $rs->all ];
}
1;

