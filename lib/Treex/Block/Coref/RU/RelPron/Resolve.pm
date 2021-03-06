package Treex::Block::Coref::RU::RelPron::Resolve;
use Moose;
use Treex::Core::Common;
extends 'Treex::Block::Coref::Resolve';
with 'Treex::Block::Coref::RU::RelPron::Base';

#use Treex::Tool::Coreference::PerceptronRanker;
#use Treex::Tool::Coreference::RuleBasedRanker;
#use Treex::Tool::Coreference::ProbDistrRanker;
use Treex::Tool::ML::VowpalWabbit::Ranker;

override 'build_model_path' => sub {
    my $path = '/home/mnovak/projects/coref_projection/treex_cr_train/ru/relpron/tmp/ml/';
    # BEST TRAIN
    #my $path = '/home/mnovak/projects/coref_projection/treex_cr_train/ru/relpron/tmp/ml/003_run_2017-01-21_15-24-24_5271.models_retrained_after_bugfix_in_a2t_mention_projection/002.a9a17.mlmethod/model/train.official.table.gz.vw.ranking.model';
    # BIG TRAIN
    #my $path = '/home/mnovak/projects/coref_projection/treex_cr_train/ru/relpron/tmp/ml/004_run_2017-01-23_17-41-21_7497.models_retrained_on_big_train_set/002.a9a17.mlmethod/model/big_train.official.table.gz.vw.ranking.model';
    # TRAIN AFTER PRONFIX
    #my $path = '/home/mnovak/projects/coref_projection/treex_cr_train/ru/relpron/tmp/ml/005_run_2017-01-26_18-09-05_9802.after_pronfix.train/002.a9a17.mlmethod/model/train.official.table.gz.vw.ranking.model';
    # TRAIN-SMALL_DEV AFTER PRONFIX
    $path .= '006_run_2017-01-28_01-31-42_20993.on_train-small_dev/002.a9a17.mlmethod/model/train-small_dev.official.table.gz.vw.ranking.model';
    print STDERR "MODEL_PATH: $path\n";
    return $path;
};

override '_build_ranker' => sub {
    my ($self) = @_;
#    my $ranker = Treex::Tool::Coreference::RuleBasedRanker->new();
#    my $ranker = Treex::Tool::Coreference::ProbDistrRanker->new(
#    my $ranker = Treex::Tool::Coreference::PerceptronRanker->new( 
    my $ranker = Treex::Tool::ML::VowpalWabbit::Ranker->new( 
        { model_path => $self->model_path } 
    );
    return $ranker;
};

1;

#TODO adjust documentation

__END__

=encoding utf-8

=head1 NAME 

Treex::Block::Coref::RU::RelPron::Resolve

=head1 RUSCRIPTION

Pronoun coreference resolver for German.
Settings:
* German personal pronoun filtering of anaphor
* candidates for the antecedent are nouns from current (prior to anaphor) and previous sentence
* German pronoun coreference feature extractor
* using a model trained by a VW ranker

=head1 AUTHORS

Michal Novák <mnovak@ufal.mff.cuni.cz>

=head1 COPYRIGHT AND LICENSE

Copyright © 2011-2016 by Institute of Formal and Applied Linguistics, Charles University in Prague

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself.
