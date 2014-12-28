package Complete::Dist;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;
#use Log::Any '$log';

use Complete;

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
        ci => {
            summary => 'Whether to do case-insensitive search',
            schema  => 'bool*',
        },
    },
    result_naked => 1,
};
sub complete_module {
    require Complete::Path;

    my %args = @_;

    my $word = $args{word} // '';
    my $ci = $args{ci} // $Complete::OPT_CI;

    $word =~ s!(::|-|/|\.)!-!g;
    Complete::Util::complete_array_elem(
        word  => $word,
        array => [Dist::Util::list_dists()],
        ci    => $args{ci},
    );
}

1;
#ABSTRACT:

=head1 SYNOPSIS

 use Complete::Dist qw(complete_dist);
 my $res = complete_dist(word => 'Text-AN');
 # -> ['Text-ANSI-Util', 'Text-ANSITable']


=head1 TODO

$OPT_SHORTCUT_PREFIXES like in Complete::Module?

=cut
