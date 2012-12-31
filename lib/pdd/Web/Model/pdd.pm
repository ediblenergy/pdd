package pdd::Web::Model::pdd;
use pdd::Web::BoilerPlate;
extends 'Catalyst::Model::DBIC::Schema';
has '+schema_class' => (
    default => 'pdd::Schema'
);
1;
