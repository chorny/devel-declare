use inc::Module::Install 0.75;

use 5.008001;

use ExtUtils::Depends;

name 'Devel-Declare';
all_from 'lib/Devel/Declare.pm';

requires 'Scalar::Util' => 1.11; #set_prototype appeared in this version
requires 'B::Hooks::OP::Check' => '0.18';
requires 'B::Hooks::EndOfScope' => '0.05';
requires 'Sub::Name';

build_requires 'B::Hooks::OP::Check' => '0.18';

configure_requires 'ExtUtils::Depends' => 0.302; #minimum version that works on Win32+gcc
configure_requires 'B::Hooks::OP::Check' => '0.18';
#minimum version that depends on ExtUtils::Depends 0.302

repository 'http://github.com/rafl/devel-declare/tree';

postamble(<<'EOM');
$(OBJECT) : stolen_chunk_of_toke.c
EOM

my $pkg = ExtUtils::Depends->new('Devel::Declare', 'B::Hooks::OP::Check');

WriteMakefile(
  dist => {
    PREOP => 'pod2text lib/Devel/Declare.pm >$(DISTVNAME)/README'
  },
  $pkg->get_makefile_vars,
);
