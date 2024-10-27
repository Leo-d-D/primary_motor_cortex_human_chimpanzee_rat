library(reticulate)
scipy_sparse <- import("scipy.sparse")
args = commandArgs(trailingOnly=TRUE)

gene_file <- args[1]
cell_file <- args[2]
count_file <- args[3]

run_limmatrend<-function(processed,cellinfo,cov=T,former.meth=''){
  library(limma)
  library(edgeR)
  library(dplyr)
  library(magrittr)
  count_df<-processed
  rownames(cellinfo)=cellinfo$cell_id
  cellinfo<-cellinfo[colnames(processed),]
  #cellinfo$subclass%<>%factor()
  #cellinfo$batch%<>%factor()
 
  cellinfo.cov<-cellinfo[,c('celltype','batch')]
  ## Convert to an edgeR object
  dgeObj <- DGEList(count_df)
  ## Perform TMM normalisation
  dgeObj <- calcNormFactors(dgeObj)
  logCPM <- cpm(dgeObj, log=TRUE, prior.count=3)
  if(cov){
    design<-model.matrix(formula(paste(c("~ 0 +  celltype", setdiff(colnames(cellinfo.cov),c('celltype'))), collapse = '+')), data=cellinfo.cov)
  }else{
    design <- model.matrix(~ celltype, data=cellinfo.cov)
  }
  subclass_list <- unique(cellinfo.cov$celltype)
  for (i in subclass_list) {
    temp_cellinfo <- cellinfo.cov
    print(i)
    temp_cellinfo$celltype[temp_cellinfo$celltype != i] <- "other"
    temp_cellinfo$celltype%<>%factor()
    temp_cellinfo$batch%<>%factor()
    
    #temp_cellinfo %<>% mutate(subclass = replace(subclass, subclass != i, "other"))
    print(levels(temp_cellinfo$celltype))
    design <- model.matrix(formula(paste(c("~ 0 +  celltype", setdiff(colnames(temp_cellinfo),c('celltype'))), collapse = '+')), data=temp_cellinfo)
    print(design[1,])
    constrasts <- makeContrasts(contrasts=paste(paste0("celltype",i),"-",paste0("celltype","other"),sep=""),levels = design)
    lmfit <- lmFit(logCPM, design)
    fitcontrasts <- contrasts.fit(lmfit,constrasts)
    #lmfit <- eBayes(lmfit, trend=TRUE, robust = TRUE)
    fitcontrasts2 <- eBayes(fitcontrasts,trend=TRUE, robust = TRUE)
    res_table <- topTable(fitcontrasts2, n = Inf, adjust.method = "BH")
    res_name<-paste0(ifelse(former.meth=='','',paste0(former.meth,'+')),i ,'_limmatrend',ifelse(cov,'_Cov',''))
    save(res_table, temp_cellinfo, file=paste0(res_name,'.rda'))
    write.table(res_table,paste0(res_name, ".tsv"),quote=F,sep="\t")
  }
  #constrasts <- makeContrasts(subclassGABAergic - subclassGlutamatergic, subclassGABAergic - subclassNon_Neuronal, subclassGlutamatergic - subclassNon_Neuronal,levels = design)

  #lmfit <- lmFit(logCPM, design)
  #fitcontrasts <- contrasts.fit(lmfit,constrasts)
  #lmfit <- eBayes(lmfit, trend=TRUE, robust = TRUE)
  #fitcontrasts2 <- eBayes(fitcontrasts,trend=TRUE, robust = TRUE)
  #res_table <- topTable(fitcontrasts2, n = Inf, adjust.method = "BH", coef = 2)
  #res <- data.frame('pvalue' = res_table$P.Value, 
  #                           'adjpvalue' = res_table$adj.P.Val, 
  #                           'logFC' = res_table$logFC,
  #                           row.names = rownames(res_table))

  #res_name<-paste0(ifelse(former.meth=='','',paste0(former.meth,'+')),'limmatrend',ifelse(cov,'_Cov',''))
  #save(res, cellinfo, file=paste0('./',res_name,'.rda'))
  #write.table(res_table,"res.txt",quote=F,sep="\t")
  #return(res_name)
}

print('read in cell inf')
counts <- scipy_sparse$load_npz(count_file)
counts_df <- as.data.frame(t(as.matrix(counts)))
cellinfo <- read.table(cell_file, sep="\t", header = T)
colnames(counts_df) <- cellinfo$cell_id
genes <- read.table(gene_file,sep="\t",header=T)
head(genes)
rownames(counts_df) <- genes$gene
run_limmatrend(counts_df, cellinfo)
