package Data::Page::Any;

use Carp;
use strict;
use warnings;
use base 'Data::Page::Nav';
__PACKAGE__->mk_accessors(qw/list_total_entries/);

our $VERSION = '0.01';

sub new {
    my $class = shift;
    my $self  = {};
    bless($self, $class);    

    my $list_total_entries = [];

    if (ref($_[0]) eq 'ARRAY') {
        $list_total_entries = shift;
    } else {
        $list_total_entries = [shift];
    }
    
    my $total_entries = 0;
    $total_entries += $_ for @$list_total_entries;
    
    my ($entries_per_page, $current_page) = @_;
    
    $self->list_total_entries($list_total_entries || []);
    $self->total_entries($total_entries           || 0);
    $self->entries_per_page($entries_per_page     || 10);
    $self->current_page($current_page             || 1);
    
    return $self;    
}

sub limits {
    my $self = shift;
    
    my $total = $self->skipped;
    my $num = 0;
    
    my $limits = [];
    
    for my $total_entries (@{$self->list_total_entries}) {        
        $num += $total_entries;
        $total = $num - $total if $total == $self->skipped;
        
        my $limit;
        
        if ($total >= $self->entries_per_page) {
            $limit = $self->entries_per_page;
            $total = 0;
        } elsif ($total > 0) {
            $limit = $total;
            $total = $self->entries_per_page - $total;
        } else {
            $limit = 0;
            $total = $self->entries_per_page + $self->skipped;
        }
        
        push(@$limits, $limit);
    }
    
    return $limits;
}

sub offsets {
    my $self = shift;
    
    my $skipped = $self->skipped;
    my $total = $skipped;
    my $index = 0;
    my $num = 0;
    
    my $offsets = [];
    
    for my $total_entries (@{$self->list_total_entries}) {
        $num += $total_entries;
        $total = $num - $total if $total == $self->skipped;
        
        my $offset;
        
        if ($total >= $self->entries_per_page) {
            $offset = $index > 0 
                    ? $self->skipped - $self->list_total_entries->[$index - 1]
                    : $self->skipped;
            $total = 0;
        } elsif ($total > 0) {
            $offset = $index > 0 
                    ? $skipped - $self->list_total_entries->[$index - 1]
                    : $skipped;            
            $skipped += $total;
            $total = $self->entries_per_page - $total;
        } else {
            $offset = 0;
            $total = $self->entries_per_page + $self->skipped;
        }
        
        push(@$offsets, $offset);
        
        $index++;
    }
    
    return $offsets;
}

1;
