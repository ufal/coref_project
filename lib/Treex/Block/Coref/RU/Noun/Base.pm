package Treex::Block::Coref::RU::Noun::Base;
use Moose::Role;
use Treex::Core::Common;

use Treex::Tool::Coreference::AnteCandsGetter;
#use Treex::Tool::Coreference::Features::RU::AllMonolingual;
use Treex::Tool::Coreference::Features::RU::Noun;

with 'Treex::Block::Coref::SupervisedBase' => {
    -excludes => [ '_build_feature_extractor', '_build_ante_cands_selector' ],
};

sub _build_node_types {
    return 'noun.only';
}

#sub _build_feature_extractor {
#    my ($self) = @_;
#    return Treex::Tool::Coreference::Features::Noun->new();
#}

sub _build_feature_extractor {
    my ($self) = @_;
    #my $fe = Treex::Tool::Coreference::Features::RU::AllMonolingual->new();
    my $fe = Treex::Tool::Coreference::Features::RU::Noun->new();
    return $fe;
}

sub _build_ante_cands_selector {
    my ($self) = @_;
    my $acs = Treex::Tool::Coreference::AnteCandsGetter->new({
        cand_types => [ 'noun.only' ],
        prev_sents_num => 5,
        cands_within_czeng_blocks => 1,
        max_size => 100,
    });
    return $acs;
}

1;

#TODO extend documentation

__END__

=head1 NAME

Treex::Block::Coref::RU::Noun::Base

=head1 DESCRIPTION

This role is a basis for supervised coreference resolution of Russian personal pronouns.
Both the data printer and resolver should apply this role.

=head1 AUTHOR

Michal Novak <mnovak@ufal.mff.cuni.cz>

=head1 COPYRIGHT AND LICENSE

Copyright © 2011-2016 by Institute of Formal and Applied Linguistics, Charles University in Prague

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself.