# Real-time_b_value_Costa_Marchigiana

This is a repository containing the code to generate the results in the paper "Real Time Gutenberg-Richter b-value Estimation for an Ongoing Seismic Sequence: an Application to the 2022 Marche Offshore Earthquake Sequence (ML 5.7 Central Italy)", by I. Spassiani, M.Taroni, M. Murru and G. Falcone.

The final script to obtain the figure relative to the estimated b-values is: Script_Select_events_And_B_estimation.m
This script uses the function Analysis.m, where, by using in turn the functions MagDistr.m and BvalueEstimation.m, we compute magnitude PDF and CDF and the numerical estimate for the b-value (with the relative error). 


Reference:
https://academic.oup.com/gji/advance-article-abstract/doi/10.1093/gji/ggad134/7086114?utm_source=advanceaccess&utm_campaign=gji&utm_medium=email
