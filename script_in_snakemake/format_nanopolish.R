#!/usr/bin/env Rscript

# Author: Zaka Yuen , JCSMR, ANU
# Created on July 2020
# Modified on March 2021

# This script is to:
# -create a per-read prediction output that is formatted to be used in METEORE for the subsequent consensus prediction
  
args = commandArgs(trailingOnly=TRUE)

df <- read.table(args[1], header = TRUE, sep = "\t", stringsAsFactors = TRUE)
colnames(df) <- c("Chr", "Pos", "Strand", "Score", "ID")
df[df$Strand == "-","Pos"] <- df[df$Strand == "-","Pos"]+1
df <- df[, c("ID", "Chr", "Pos", "Strand", "Score")]
df$Pos <- format(df$Pos,scientific=FALSE)
write.table(df, file=args[2], sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
