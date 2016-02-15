package File::Util::Tempdir;

# DATE
# VERSION

#use 5.010001;
use strict;
use warnings;

use Exporter qw(import);
our @EXPORT_OK = qw(get_tempdir);

sub get_tempdir {
    if ($^O eq 'MSWin32') {
        for (qw/TMP TEMP TMPDIR TEMPDIR/) {
            return $ENV{$_} if defined $ENV{$_};
        }
        for ("C:\\TMP", "C:\\TEMP") {
            return $_ if -d;
        }
    } else {
        for (qw/TMPDIR TEMPDIR TMP TEMP/) {
            return $ENV{$_} if defined $ENV{$_};
        }
        for ("/tmp", "/var/tmp") {
            return $_ if -d;
        }
    }
    die "Can't find any temporary directory";
}

1;
# ABSTRACT: Cross-platform way to get system-wide temporary directory

=head1 SYNOPSIS

 use File::Util::Tempdir qw(get_tempdir);

 my $dir = get_tempdir();


=head1 DESCRIPTION


=head1 FUNCTIONS

None are exported by default, but they are exportable.

=head2 get_tempdir() => str

A cross-platform way to get system-wide temporary directory.

On Windows: it first looks for one of these environment variables in this order
and return the first value that is set: C<TMP>, C<TEMP>, C<TMPDIR>, C<TEMPDIR>.
If none are set, will look at these directories in this order and return the
first value that is set: C<C:\TMP>, C<C:\TEMP>. If none are set, will die.

On Unix: it first looks for one of these environment variables in this order and
return the first value that is set: C<TMPDIR>, C<TEMPDIR>, C<TMP>, C<TEMP>. If
none are set, will look at these directories in this order and return the first
value that is set: C</tmp>, C</var/tmp>. If none are set, will die.



=head1 SEE ALSO

L<File::Spec> has C<tmpdir> function. It also tries to look at environment
variables, e.g. on Unix it will look at C<TMPDIR> (but not C<TEMPDIR>) and
then falls back to C</tmp> (but not C</var/tmp>).

L<File::HomeDir>, a cross-platform way to get user's home directory and a few
other related directories.

L<File::Temp> to create a temporary directory.
