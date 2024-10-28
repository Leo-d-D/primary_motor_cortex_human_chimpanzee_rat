#!/bin/bash
adata=$1
model=$2
meta=$3

####predictAll doesn't use predMetadata

echo "devCellPy --runMode predictAll --rejectionCutoff 0.5 --predNormExpr $adata  --layerObjectPaths "$model/Root_object.pkl", "$model/L2L3IT_object.pkl", "$model/L5ET_object.pkl", "$model/L6IT_object.pkl", "$model/L5IT_object.pkl", "$model/L56NP_object.pkl", "$model/L6b_object.pkl", "$model/L6CT_object.pkl" --predMetadata $3 "
devCellPy --runMode predictAll --rejectionCutoff 0.5 --predNormExpr $adata  --layerObjectPaths "$model/Root_object.pkl","$model/L2L3IT_object.pkl","$model/L5ET_object.pkl","$model/L6IT_object.pkl","$model/L5IT_object.pkl","$model/L56NP_object.pkl","$model/L6b_object.pkl","$model/L6CT_object.pkl" --predMetadata $meta

echo "devCellPy --runMode predictAll --rejectionCutoff 0.5 --predNormExpr $adata  --layerObjectPaths "$model/Root_object.pkl","$model/L2L3IT_object.pkl","$model/L5ET_object.pkl","$model/L6IT_object.pkl","$model/L5IT_object.pkl","$model/L6ITCar3_object.pkl","$model/L6b_object.pkl" --predMetadata $meta"
devCellPy --runMode predictAll --rejectionCutoff 0.5 --predNormExpr $adata  --layerObjectPaths "$model/Root_object.pkl","$model/L2L3IT_object.pkl","$model/L5ET_object.pkl","$model/L6IT_object.pkl","$model/L5IT_object.pkl","$model/L6ITCar3_object.pkl","$model/L6b_object.pkl" --predMetadata $meta
