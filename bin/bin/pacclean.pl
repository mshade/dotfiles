#!/usr/bin/env perl

use strict;
use warnings;
use Term::ReadKey;

my %keys = GetControlChars;
my @packages = @ARGV;
my @toremove;

ReadMode "cbreak";
for my $package (@packages) {
   system( 'pacman', '-Qi', $package );
   print "Remove $package? [y/N] ";

   my $response = lc ReadKey;
   if ($response eq "y") {
      push( @toremove, $package );
   }
   elsif ($response eq $keys{EOF} ) {
      printf "\n";
      last;
   }
   printf "\n";
}
ReadMode "normal";

exit unless @toremove;
print "Targets: @toremove\n";
system( 'sudo', 'pacman', '-Rs', @toremove );
