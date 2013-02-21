use strict;
use warnings;
use Module::Build;

Module::Build->new(
    module_name => 'Data::FormValidator::URI',
    license     => 'artistic_2',
    dist_author => 'Graham TerMarsch (cpan@howlingfrog.com)',
    requires    => {
        'Data::FormValidator' => 4,
        'URI'                 => 0,
    },
)->create_build_script;
