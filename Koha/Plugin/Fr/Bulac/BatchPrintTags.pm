package Koha::Plugin::Com::ByWaterSolutions::KitchenSink;

use Modern::Perl;
use base qw(Koha::Plugins::Base);

use Koha::Items;

use Cwd qw(abs_path);
use Data::Dumper;


our $VERSION = "0.0.1";
our $MINIMUM_VERSION = "21.11";

our $metadata = {
    name            => 'Batch print tags',
    author          => 'Nicolas Legrand',
    date_authored   => '2023-05-31',
    date_updated    => "1900-01-01",
    minimum_version => $MINIMUM_VERSION,
    maximum_version => undef,
    version         => $VERSION,
    description     => 'This plugin permits to scan multiple barcodes '
      . 'and then ask to print all the tags of the library.'
      . 'It will only work with the specific installation of the BULAC',
};

sub new {
    my ( $class, $args ) = @_;

    $args->{'metadata'} = $metadata;
    $args->{'metadata'}->{'class'} = $class;

    my $self = $class->SUPER::new($args);

    return $self;
}

sub report {
    my ( $self, $args ) = @_;
    my $cgi = $self->{'cgi'};
    my $template = $self->get_template({ file => 'report.tt' });

    $self->output_html( $template->output() );
}

sub tool {
    my ( $self, $args ) = @_;

    my $cgi = $self->{'cgi'};

    unless ( $cgi->param('submitted') ) {
        $self->tool_print_tags();
    }
    else {
        $self->tool_list_item();
    }

}


sub tool_print_tags {
    my ( $self, $args ) = @_;
    my $cgi = $self->{'cgi'};

    my $template = $self->get_template({ file => 'tool-print-tags.tt' });

    $self->output_html( $template->output() );
}

sub tool_list_items {
    my ( $self, $args ) = @_;
    my $cgi = $self->{'cgi'};

    my $template = $self->get_template({ file => 'tool-list-items.tt' });

    $self->output_html( $template->output() );
}

1;
