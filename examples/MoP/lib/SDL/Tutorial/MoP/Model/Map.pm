package SDL::Tutorial::MoP::Model::Map;

use strict;
use warnings;

use base 'SDL::Tutorial::MoP::Base';

use File::ShareDir qw(module_file);
use Carp;

use SDL;
use SDL::Video;
use SDL::Tutorial::MoP::Models;

#BEGIN {
#    use Exporter ();
#    use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);
#    $VERSION     = '0.01';
#    @ISA         = qw(Exporter);
#    #Give a hoot don't pollute, do not export more than needed by default
#    @EXPORT      = qw();
#    @EXPORT_OK   = qw(draw_map);
#    %EXPORT_TAGS = ();
#}

my $tile_size     = 10;
my @map           = ();

my @map_center    = (32, 24); # x, y

my $path          = module_file('SDL::Tutorial::MoP', 'data/tiles.bmp');
my $tiles         = SDL::Video::load_BMP($path);
croak 'Error: '.SDL::get_error() if(!$tiles);

sub new
{
	my ($class, %params) = (@_);

	my $self = $class->SUPER::new(%params);

	$self->evt_manager->reg_listener($self);
	$self->init(%params);

	return $self;
}

sub init 
{
    my ($self, %params) = @_;
    
    @map = $self->load_map();
    
	$self->{map} ||= [];
}

sub notify
{
    my ($self, $event) = (@_);
 
    print carp(sprintf("Notify '%s'in Map", $event->{name})) if $self->{EDEBUG};
 
    my %event_action = (
        'MapMoveRequest' => sub {
            $self->move_map($event->{direction}) if ($self->{map});
            $self->evt_manager->post({ name => 'MapMove' });
        },
    );

    my $action = $event_action{$event->{name}};
    
    if (defined $action) {
        print "Event $event->{name}\n" if $self->{GDEBUG};
        $action->();
    }
}

sub move_map
{
	my $self = shift;
	my $direction = shift;
	
	$map_center[0]++ if $direction eq 'LEFT';
	$map_center[0]-- if $direction eq 'RIGHT';
	$map_center[1]++ if $direction eq 'UP';
	$map_center[1]-- if $direction eq 'DOWN';
}

sub load_map
{
	my $path = module_file('SDL::Tutorial::MoP', 'data/main.map');
	open (FH, $path)  || die "Can not open file $path: $!";
	while(<FH>)
	{
		my @row = split(//, $_);
		push(@map, \@row);
	}
	close(FH);
	
	return @map;
}

sub get_tile
{
	my $self = shift;
	my $x    = shift;
	my $y    = shift;
	
	return $self->get_tile_by_index(${$map[$y + $map_center[1]]}[$x + $map_center[0]] ? 5 : 6);
}

sub get_tile_by_index
{
	my $self = shift;
	my $index = shift || 0;

	carp 'Unable to load tiles ' . SDL::get_error() if(!$tiles);

	my $x = ($index * $tile_size) % $tiles->w;
	my $y = int(($index * $tile_size) / $tiles->w) * $tile_size;
	
  	return SDL::Rect->new($x, $y, $tile_size, $tile_size);
}

sub tile_size
{
	my $self = shift;
	$tile_size = shift || return $tile_size;
}

sub tiles
{
	my $self = shift;
	$tiles = shift || return $tiles;
}



1;