#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 4;
use Data::FormValidator::URI;
use Data::FormValidator;

###############################################################################
# TEST: URI Constraint - invalid URI scheme
uri_constraint_invalid_scheme: {
    my $res = Data::FormValidator->check( {
        website => 'ftp://www.example.com',
    }, {
        required => [qw( website )],
        constraint_methods => {
            website => FV_uri(schemes => [qw( http https )]),
        },
    } );

    my $is_good = $res->valid('website');
    ok !$is_good, 'URI fails to validate when using invalid scheme';
}

###############################################################################
# TEST: URI Constraint - valid URI scheme
uri_constraint_valid_scheme: {
    my $res = Data::FormValidator->check( {
        website => 'http://www.example.com',
    }, {
        required => [qw( website )],
        constraint_methods => {
            website => FV_uri(schemes => [qw( http https )]),
        },
    } );

    my $is_good = $res->valid('website');
    ok $is_good, 'URI validates when using a valid scheme';
}

###############################################################################
# TEST: URI Constraint - invalid URI
uri_constraint_invalid_uri: {
    my $res = Data::FormValidator->check( {
        website => 'this is not a URI at all',
    }, {
        required => [qw( website )],
        constraint_methods => {
            website => FV_uri(),
        },
    } );

    my $is_good = $res->valid('website');
    ok !$is_good, 'Invalid URI correctly fails to validate';
}

###############################################################################
# TEST: URI Constraint - valid URI
uri_constraint_valid_uri: {
    my $res = Data::FormValidator->check( {
        website => 'http://www.example.com/',
    }, {
        required => [qw( website )],
        constraint_methods => {
            website => FV_uri(),
        },
    } );

    my $is_good = $res->valid('website');
    ok $is_good, 'Valid URI validates correctly';
}
