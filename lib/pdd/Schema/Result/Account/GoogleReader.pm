package pdd::Schema::Result::Account::GoogleReader;
use pdd::Schema::Result;

table 'account_google_reader';

primary_column service_credential_id => { data_type => integer };

integer_column 'user_id';

text_column 'access_token';

text_column 'refresh_token';

text_column 'token_type';

create_date;

belongs_to
  service_credential => "::ServiceCredential",
  {
    'foreign.service_credential_id' => 'self.service_credential_id',
    'foreign.user_id'               => 'self.user_id',
  },
  {
    add_fk_index => false,
  };

belongs_to
    user => "::User", 'user_id';

sub sqlt_deploy_callback {
    my ( $source_instance, $sqlt_table ) = @_;
    $sqlt_table->add_index(
        name   => 'agr_user_id_idx',
        fields => [qw/ service_credential_id user_id /]
    );
}
1;
=cut
{
    access_token => "ya29.AHES6ZSdz3vjS9Y3EiqBqtT8iK6Y15_zJe-ibU5gBHhDTdI",
    expires_at => "1358137991",
    net_oauth2_version => "0.51",
    refresh_token => "1/aMTKRxFKQuT2HK2OmjjwUo8ny6EUL_UimZT5mBuTDp4",
    token_type => "Bearer"
}
