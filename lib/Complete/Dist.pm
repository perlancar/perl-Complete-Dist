package Complete::Dist;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;
#use Log::Any '$log';

use Complete::Common qw(:all);

our %SPEC;
require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(complete_dist);

$SPEC{complete_dist} = {
    v => 1.1,
    summary => 'Complete from list of installed Perl distributions',
    description => <<'_',

Installed Perl distributions are listed using `Dist::Util::list_dists()`.

_
    args => {
        word => {
            schema => 'str*',
            req => 1,
            pos => 0,
        },
    },
    result_naked => 1,
};
sub complete_dist {
    require Complete::Util;
    require Dist::Util;

    my %args = @_;

    my $word = $args{word} // '';

    $word =~ s!(::|-|/|\.)!-!g;
    Complete::Util::complete_array_elem(
        word  => $word,
        array => [Dist::Util::list_dists()],
    );
}

1;
#ABSTRACT:

=head1 SYNOPSIS

 use Complete::Dist qw(complete_dist);
 my $res = complete_dist(word => 'Text-AN');
 # -> ['Text-ANSI-Util', 'Text-ANSITable']
