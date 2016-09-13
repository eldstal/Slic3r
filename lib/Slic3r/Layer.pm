# Extends the C++ class Slic3r::Layer.

package Slic3r::Layer;
use strict;
use warnings;

# the following two were previously generated by Moo
sub print {
    my $self = shift;
    return $self->object->print;
}

sub config {
    my $self = shift;
    return $self->object->config;
}

sub region {
    my $self = shift;
    my ($region_id) = @_;
    
    while ($self->region_count <= $region_id) {
        $self->add_region($self->object->print->get_region($self->region_count));
    }
    
    return $self->get_region($region_id);
}

sub regions {
    my ($self) = @_;
    return [ map $self->get_region($_), 0..($self->region_count-1) ];
}

sub make_fill {
    my ($self) = @_;
    
    foreach my $layerm (@{$self->regions}) {
        $layerm->fills->clear;
        $layerm->fills->append($_) for $self->object->fill_maker->make_fill($layerm);
    }
}

package Slic3r::Layer::Support;
our @ISA = qw(Slic3r::Layer);

1;
