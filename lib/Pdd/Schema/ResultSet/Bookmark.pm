package Pdd::Schema::ResultSet::Bookmark;
use Pdd::Schema::ResultSet;
use HTML::Entities;
use Encode;
my $_encoding = Encode::find_encoding("UTF-8");
sub encoding { $_encoding };

sub latest_bookarks {
    my $self = shift;
    my $rs =
      $self->search( undef,
        { order_by => { -desc => 'create_date' }, result_class => "::HRI" } );
    return [
        map {
            my ( $link, $title ) =
              map { $self->encoding->decode($_) } ( $_->{link}, $_->{title} );
            $link = URI->new($link);
            +{
                link  => "$link",
                title => decode_entities($title),
                host  => $link->host
              }
        } $rs->all
    ];
}
1;
