## Trends in Bioinformatics

High-throughput genomics has fundamentally changed how life scientists investigate their research questions. Instead of studying a single candidate gene, we are able to measure DNA sequences and RNA expression of every gene in a large number of genomes. This technology advance requires us to become familiar with data wrangling, programming, and statistical analysis. To meet new challenges, bioinformaticians have created a large number of software packages to deal with genomic data.

For example, molecular biologists could nowadays sequence a full human genome that results in billions of very short and randomly located DNA sequences. Such short DNA sequences (e.g., ~ hundreds base pairs) must be aligned, so that we can infer a full genome that is over 3 billion base pairs. Among many available computational methods, it is often difficult to know the most appropriate tool for one’s specific needs.

This project aims to use text mining to identify trends in bioinformatics software packages. Generally, we obtain a corpus of open access publications in genomics and analyze frequencies of software packages used for various bioinformatics tasks. Bioinformatics tools cited in manuscripts are linked with their meta data, such as publication years and regions, to find temporal and regional trends.

## Open Science

I share codes used in this research to encourage transparency, reproducibility, and collaboration. Please feel free to contribute to and collaborate on this project! In this repository, you can find the following directories:

* **Corpus**: A `Python` script is used to generate a list of commands that use `getpapers` from ContentMine. Please install `Python` (https://www.python.org/) and `getpapers` (https://github.com/ContentMine/getpapers/). Generated codes download open access articles from Europe PMC (https://europepmc.org). A subdirectory **RNAseq** includes manuscripts with a keyword "RNAseq". 
* **Rscript**: R codes to read in XML manuscript files and scan for search terms. Currently, its search and count methods do not account for the context. Beyond installing `R` (https://www.r-project.org/), please see source codes for dependencies.
* **SoftwareList**: a list of bioinformatics software packages from Wikipedia (https://en.wikipedia.org/wiki/List_of_RNA-Seq_bioinformatics_tools). I'm seeking ways to automatically generate this list and/or to be more comprehensive/specific.

These codes may contain errors or pose security risks to your systems. As always, these are provided without warranty of any kind, implied or explicit.

## Acknowledgement

This work was supported by ContentMine Fellowship during July - December, 2016. 