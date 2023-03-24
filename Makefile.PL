use ExtUtils::MakeMaker;
  
WriteMakefile(
    NAME             => 'Data::Page::Any',
    ABSTRACT         => 'Module for pages any selects',
    AUTHOR           => 'Lucas Tiago de Moraes <lucastiagodemoraes@gmail.com>',
    VERSION_FROM     => 'lib/Data/Page/Any.pm',
    LICENSE          => 'perl_5',
    MIN_PERL_VERSION => '5.008001',
  
    META_MERGE => {
        'meta-spec' => {
          version => 2,
        },
  
        resources => {
            homepage => 'https://github.com/ltmbr/Data-Page-Any',
  
            bugtracker => {
                web => 'https://github.com/ltmbr/Data-Page-Any/issues'
            },
  
            repository => {
                type => 'git',
                url  => 'git@github.com:ltmbr/Data-Page-Any.git',
                web  => 'https://github.com/ltmbr/Data-Page-Any'
            }
        }
    },
  
    PREREQ_PM => {
        'base'            => 0,
        'Data::Page::Nav' => '0.02'
    },
     
    TEST_REQUIRES => {
        'Test::More' => 0
    },    
  
    test => {
        TESTS => 't/*.t'
    }
);
