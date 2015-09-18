-- phpMyAdmin SQL Dump
-- version 3.3.2deb1ubuntu1
-- http://www.phpmyadmin.net
--


SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";



CREATE TABLE IF NOT EXISTS `reference` (
  `oganismid` int(4) DEFAULT NULL,
  `abbr` varchar(5) NOT NULL,
  `oganism` varchar(255) DEFAULT NULL,
  `pubmedid` varchar(20) DEFAULT NULL,
  `pub_title` text NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=gb2312 AUTO_INCREMENT=7687 ;

--
-- 转存表中的数据 `todeg`
--

INSERT INTO `reference` (`oganismid`,`abbr`, `oganism`, `pubmedid`, `pub_title`) VALUES
('1', 'aci', 'Acinetobacter baylyi ADP1', '18319726', 'de Berardinis V, et al (2008). A complete collection of single-gene deletion mutants of Acinetobacter baylyi ADP1. Mol Syst Biol.'),
('2', 'bsu', 'Bacillus subtilis 168', '12682299', 'Kobayashi K, et al (2003). Essential Bacillus subtilis genes. Proc Natl Acad Sci U S A, 100:4678-83'),
('3', 'eco', 'Escherichia coli MG1655', '13129938', 'Gerdes SY, et al (2003). Experimental determination and system level analysis of essential genes in Escherichia coli MG1655. J Bacteriol, 185:5673-84.'),
('4', 'ftn', 'Francisella novicida U112', '17215359', 'Gallagher LA, et al (2007). A comprehensive transposon mutant library of Francisella novicida, a bioweapon surrogate. Proc Natl Acad Sci U S A, 104:1009-14.'),
('5', 'hin', 'Haemophilus influenzae Rd KW20', '11805338', 'Akerley BJ, et al (2002). A genome-scale analysis for identification of genes required for growth or survival of Haemophilus influenzae. Proc Natl Acad Sci U S A, 99:966-71'),
('6', 'hpy', 'Helicobacter pylori 26695', '15547264', 'Salama NR, et al (2004). Global transposon mutagenesis and essential gene analysis of Helicobacter pylori. J Bacteriol, 186:7926-35.'),
('7', 'mge', 'Mycoplasma genitalium G37', '16407165', 'Glass JI, et al (2006). Essential genes of a minimal bacterium. Proc Natl Acad Sci U S A, 103:425-30.'),
('8', 'mpu', 'Mycoplasma pulmonis UAB CTIP', '18452587', 'French CT, et al (2008). Large-scale transposon mutagenesis of Mycoplasma pulmonis. Mol Microbiol.'),
('9', 'mtu', 'Mycobacterium tuberculosis H37Rv', '12657046', 'Sassetti CM, et al (2003). Genes required for mycobacterial growth defined by high density mutagenesis. Mol Microbiol, 48:77-84.'),
('10', 'pau', 'Pseudomonas aeruginosa UCBPP-PA14', '16477005', 'Liberati NT, et al (2006). An ordered, nonredundant library of Pseudomonas aeruginosa strain PA14 transposon insertion mutants. Proc Natl Acad Sci U S A, 103:2833-8.'),
('11', 'sao', 'Staphylococcus aureus NCTC 8325', '19570206', 'Chaudhuri RR, et al (2009). Comprehensive identification of essential Staphylococcus aureus genes using Transposon-Mediated Differential Hybridisation (TMDH). BMC Genomics, 10:291.'),
('12', 'spr', 'Streptococcus pneumoniae', '15995353', 'Song JH, et al (2005). Identification of Essential Genes in Streptococcus pneumoniae by Allelic Replacement Mutagenesis. Mol Cells, 19:365-74.'),
('13', 'spu', 'Staphylococcus aureus N315', '11952893', 'Forsyth RA, et al (2002). A genome-wide strategy for the identification of essential genes in Staphylococcus aureus. Mol Microbiol, 43:1387-400.'),
('14', 'stm', 'Salmonella typhimurium LT2', '15009898', 'Knuth K, et al (2004). Large-scale identification of essential Salmonella genes by trapping lethal insertions. Mol Microbiol, 51:1729-44.'),
('15', 'stt', 'Salmonella enterica serovar Typhi', '19826075', 'Langridge GC, et al (2009). Simultaneous assay of every Salmonella Typhi gene using one million transposon mutants. Genome Res, 19:2308-16'),
('16', 'vch', 'Vibrio cholerae N16961', '18574146', 'Cameron DE, Urbach MJ,Mekalanos JJ(2008). A defined transposon mutant library and its use in identifying motility genes in Vibrio cholerae. PNAS, 105(25):8736-8741.'),
('17', 'ccr', 'Caulobacter crescentus', '21878915', 'Christen B, et al (2011). The essential genome of a bacterium. Mol Syst Biol, 7:528.?'),
('18', 'ssa', 'Streptococcus sanguinis', '22355642', 'Xu, P et al(2011). Genome-wide essential gene identification in Streptococcus sanguinis. Sci. Rep. 1, 125; DOI:10.1038/srep00125.'),
('19', 'pga', 'Porphyromonas gingivalis ATCC 33277', '23114059', 'Klein BA, et al (2012). Identification of essential genes of the periodontal pathogen Porphyromonas. BMC Genomics, 13: 578.'),
('20', 'btv', 'Bacteroides thetaiotaomicron VPI-5482', '19748469', 'Goodman Al, et al (2009). Identifying Genetic Determinants Needed to Establish a Human Gut Symbiont in Its Habitat. Cell Host & Microbe, 6: 279-289.?'),
('21', 'bte', 'Burkholderia thailandensis E264', '23382856', 'Baugh, Loren, et al. Combining Functional and Structural Genomics to Sample the Essential Burkholderia Structome. PloS one 8.1 (2013): e53851.?'),
('22', 'swr', 'Sphingomonas wittichii RW1', '23601288', 'Roggo, Clemence, et al. Genome-wide transposon insertion scanning of environmental survival functions in the polycyclic aromatic hydrocarbon degrading bacterium Sphingomonas wittichii RW1. Environmental microbiology (2013).?'),
('23', 'som', 'Shewanella oneidensis MR-1', '22125499', 'Deutschbauer, Adam, et al. Evidence-based annotation of gene function in Shewanella oneidensis MR-1 using genome-wide fitness profiling across 121 conditions. PLoS genetics 7.11 (2011): e1002385.?'),
('24', 'set', 'Salmonella enterica serovar Typhimurium SL1344', '23470992', 'Barquist, Lars, et al. A comparison of dense transposon insertion libraries in the Salmonella serovars Typhi and Typhimurium. Nucleic acids research 41.8 (2013): 4549-4564.?'),
('25', 'bfr', 'Bacteroides fragilis 638R', '24899126', 'Yaligara Veeranagouda, et al (2014). Identification of genes required for the survival of B. fragilis using massive parallel sequencing of a saturated transposon mutant library. BMC Genomics, 15:429.?'),
('26', 'bpk', 'Burkholderia pseudomallei K96243', '24520057', 'Moule, M.G., et al. (2014) Genome-Wide Saturation Mutagenesis of Burkholderia pseudomallei K96243 Predicts Essential Genes and Novel Targets for Antimicrobial Development. MBio 5, e00926-00913?'),
('27', 'ses', 'Salmonella enterica subsp. enterica serovar Typhimurium str. 14028S', '22367088', 'Khatiwara, Anita, et al. Genome scanning for conditionally essential genes in salmonella enterica serotype typhimurium. Applied and environmental microbiology 78.9 (2012): 3098-3107.'),
('28', 'pap', 'Pseudomonas aeruginosa PAO1', '25775563', 'Turner, K.H., Wessel, A.K., Palmer, G.C., Murray, J.L. and Whiteley, M. (2015) Essential genome of Pseudomonas aeruginosa in cystic fibrosis sputum. Proc. Natl. Acad. Sci. U. S. A.?'),
('29', 'cjs', 'Campylobacter jejuni subsp. jejuni NCTC 11168 = ATCC 700819', '22044676', 'Metris, Aline, et al. In vivo and in silico determination of essential genes of Campylobacter jejuni. BMC genomics 12.1 (2011): 535.');
