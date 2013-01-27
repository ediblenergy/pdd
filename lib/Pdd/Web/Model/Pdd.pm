package Pdd::Web::Model::Pdd;
use Pdd::Web::BoilerPlate;
extends 'Catalyst::Model::DBIC::Schema';
has '+schema_class' => (
    default => 'Pdd::Schema'
);
1;
