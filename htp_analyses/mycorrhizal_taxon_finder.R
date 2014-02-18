## for ectomycorrhizal taxa see:
## Tedersoo, May & Smith. 2010. Mycorrhiza 20: 217-263 
## Rinaldi, Comandini & Kuyper. 2008. Fungal Diversity 33: 1-45

rm(list = ls())
blnk <- 0

### user selects the mycorrhizal taxa list (mycorrhizal_genera.txt) from the folder where they placed it ###
pth_taxa <- file.choose()

### read mycorrhizal taxa list ###
mr_taxa_data <- read.table(pth_taxa, header=TRUE, sep="\t", na.strings="NA")
mr_taxa <- as.vector(mr_taxa_data[,1])
X <- length(mr_taxa)

### user selects their otu table - must be formatted as tab deliniated text ###
pth_otu <- file.choose()
otu_table <- read.table(pth_otu, header=TRUE, sep="\t", na.strings="NA")

### create the output file path ###
pth_out <- pth_otu
pth_out <- strsplit(pth_out, split="/")
pth_out <- pth_out[[1]]
pth_out_len <- length(pth_out)
pth_out[pth_out_len] <- "otu_mycorrhizal_taxa.txt"
pth_out <- paste(pth_out, collapse="/")

### user finds the column holding the taxon strings and inputs the column number when prompted ###
cats <- colnames(otu_table)
print(cats)
the_taxa <- readline("Please enter the number of the column that contains the taxonomic strings.");
the_taxa <- as.numeric(the_taxa);
the_taxa <- as.vector(otu_table[,the_taxa])

### write the column headings to the output file ###
### likelihood interpretation follows: ###
### Highly Probable = mycorrhizal association firmly established experimentally and in the literature ###
### Probable = mycorrhizal association very likely but not firmly established ###
### Possible = taxon contains mycorrhizal and non-mycorrhizal species - must be determined on a species-to-species basis ###
### Conflicting Reports = conflicting reports exist in the literature ###
dt_out <- c("TAXONOMIC STRING", "TAXON", "MYCORRHIZAL STATUS", "LIKELIHOOD", "CITATION")
write(dt_out, pth_out, ncolumns = 5, append=T, sep="\t")

### search for known/potential ectomycorrhizal taxa from the mycorrhizal taxa list ###
for (i in 1:X){
  mr_taxon <- as.character(mr_taxa[i])
  the_spot <- grep(mr_taxon,the_taxa)
  l_spot <- length(the_spot)
 
  if(l_spot > 0){
    for(j in 1:l_spot){
      otu_spot <- the_spot[j]
      otu_string <- the_taxa[otu_spot]
      break_string <- strsplit(otu_string, split="; ")
      break_string <- break_string[[1]]
      break_string <- break_string[6:7]
      break_string <- paste(break_string, collapse="")
      chk_spot <- grep(mr_taxon, break_string)
      chk_spot <- length(chk_spot)
      
      if(chk_spot > 0){
        likeli <- as.character(mr_taxa_data[i,3])
        citati <- as.character(mr_taxa_data[i,4])
        dt_out <- c(otu_string, mr_taxon, "Ectomycorrhizal", likeli, citati)
        write(dt_out, pth_out, ncolumns = 5, append=T, sep="\t")
      }else blnk <- blnk + 1  
    }
  }else blnk <- blnk + 1
}

### search for families that are primarily mycorrhizal and contain many species ###
mr_families <- c("Amanitaceae", "Cantharellaceae", "Boletaceae", "Cortinariaceae", "Russulaceae", "Suillaceae")

for (k in 1:6){
  mr_taxon_2 <- mr_families[k]
  the_spot_2 <- grep(mr_taxon_2,the_taxa)
  l_spot_2 <- length(the_spot_2)

  if(l_spot_2 > 0){
    for(l in 1:l_spot_2){
      otu_spot_2 <- the_spot_2[l]
      otu_string_2 <- the_taxa[otu_spot_2]
      break_string_2 <- strsplit(otu_string_2, split="; ")
      break_string_2 <- break_string_2[[1]]
      break_string_2 <- break_string_2[6:7]
      break_string_2 <- paste(break_string_2, collapse="")
      chk_spot_2 <- nchar(break_string_2)

      if(chk_spot_2 <= 4){
        dt_out <- c(otu_string_2, mr_taxon_2, "Ectomycorrhizal", "Probable", "Cannon & Kirk. 2007. Fungal Families of the World")
        write(dt_out, pth_out, ncolumns = 5, append=T, sep="\t")
      }else blnk <- blnk + 1
    }
  }else blnk <- blnk + 1
}

### search for the phylum Glomeromycota, which is almost exclusively endomycorrhizal ###
mr_taxon_3 <- "Glomeromycota"
the_spot_3 <- grep(mr_taxon_3,the_taxa)
l_spot_3 <- length(the_spot_3)

if(l_spot_3 > 0){
  for(m in 1:l_spot_3){
    otu_spot_3 <- the_spot_3[m]
    otu_string_3 <- the_taxa[otu_spot_3]
    dt_out <- c(otu_string_3, "Glomeromycota", "Endomycorrhizal", "Highly Probable", "Schussler, Schwarzott  & Walker. 2001. Mycological Research 105: 1413-1421")
    write(dt_out, pth_out, ncolumns = 5, append=T, sep="\t")
  }
}else blnk <- blnk + 1
