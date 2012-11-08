use Test::More;
use Tie::Hash::MultiValueOrdered;

my $tied = tie my %hash, "Tie::Hash::MultiValueOrdered";

$hash{a} = 1;
$hash{b} = 2;
$hash{a} = 3;
$hash{b} = 4;

# Order of keys is predictable
is_deeply(
	[ keys %hash ],
	[ qw( a b ) ],
);

# Order of values is predictable
# Note that the last values of 'a' and 'b' are returned.
is_deeply(
	[ values %hash ],
	[ qw( 3 4 ) ],
);

# Can retrieve list of all key-value pairs
is_deeply(
	[ $tied->pairs ],
	[ qw( a 1 b 2 a 3 b 4 ) ],
);

# Switch the retrieval mode for the hash.
$tied->fetch_first;

# Now the first values of 'a' and 'b' are returned.
is_deeply(
	[ values %hash ],
	[ qw( 1 2 ) ],
);

# Switch the retrieval mode for the hash.
$tied->fetch_list;

# Now arrayrefs are returned.
is_deeply(
	[ values %hash ],
	[ [1,3], [2,4] ],
);

# Restore the default retrieval mode for the hash.
$tied->fetch_last;

done_testing;
