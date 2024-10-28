#!/bin/bash

model=$1

#chimp
echo "devCellPy --runMode featureRankingOne --trainNormExpr /rhome/yjin/Proj/devCellPy/chimp/chimp_adata_rmL6CT_rmL56NP.pkl --trainMetadata /rhome/yjin/Proj/devCellPy/chimp/chimp_metadata_rmL6_CT_rmL56_NP.csv --layerObjectPaths "$model/Root_object.pkl","$model/L2L3IT_object.pkl","$model/L5ET_object.pkl","$model/L6IT_object.pkl","$model/L5IT_object.pkl","$model/L6ITCar3_object.pkl","$model/L6b_object.pkl" --featureRankingSplit 0.3"

devCellPy --runMode featureRankingOne --trainNormExpr /rhome/yjin/Proj/devCellPy/chimp/chimp_adata_rmL6CT_rmL56NP.pkl --trainMetadata /rhome/yjin/Proj/devCellPy/chimp/chimp_metadata_rmL6_CT_rmL56_NP.csv --layerObjectPaths "$model/Root_object.pkl","$model/L2L3IT_object.pkl","$model/L5ET_object.pkl","$model/L6IT_object.pkl","$model/L5IT_object.pkl","$model/L6ITCar3_object.pkl","$model/L6b_object.pkl" --featureRankingSplit 0.3

#human
echo "devCellPy --runMode featureRankingOne --trainNormExpr /rhome/yjin/Proj/devCellPy/human/human_adata_rmL6_IT_Car3.pkl --trainMetadata /rhome/yjin/Proj/devCellPy/human/human_metadata_rmL6_IT_Car3.csv  --layerObjectPaths "$model/Root_object.pkl","$model/L2L3IT_object.pkl","$model/L5ET_object.pkl","$model/L6IT_object.pkl","$model/L5IT_object.pkl","$model/L56NP_object.pkl","$model/L6b_object.pkl","$model/L6CT_object.pkl" --featureRankingSplit 0.3"

devCellPy --runMode featureRankingOne --trainNormExpr /rhome/yjin/Proj/devCellPy/human/human_adata_rmL6_IT_Car3.pkl --trainMetadata /rhome/yjin/Proj/devCellPy/human/human_metadata_rmL6_IT_Car3.csv  --layerObjectPaths "$model/Root_object.pkl","$model/L2L3IT_object.pkl","$model/L5ET_object.pkl","$model/L6IT_object.pkl","$model/L5IT_object.pkl","$model/L56NP_object.pkl","$model/L6b_object.pkl","$model/L6CT_object.pkl" --featureRankingSplit 0.3
