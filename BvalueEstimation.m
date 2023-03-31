function [ B , N , Sigma ] = BvalueEstimation( Data , MagnitudeColumn , MC , Bin )

% INPUT :
% Data = catalogue of events
% MagnitudeColumn = the magnitude column of the catalogue
% MC = the magnitude of completeness of the catalogue
% Bin = bin of the magnitudes in the catalogue (usually for Mw is 0.01
%       and for ML is 0.1);

% OUTPUT :
% B = b-value Maximum Likelihood Estimation (of the Gutenberg-Richter law) 
%   taking into account the bin of the magnitudes 
% N = total number of events bigger or equal to MC
% Sigma = b-value uncertainty


% select the events above the magnitude of completeness and 
% subtract the corresponding magnitude of completeness to each magnitude
DataOk = Data( Data( : , MagnitudeColumn ) >= MC , MagnitudeColumn ) - MC  ;

% take the total number of events
N = length( DataOk ) ; 

% compute b-value using the equation from Taroni 2021 - GJI
B = ( ( N-1 ) / N ) /( log(10)*( mean( DataOk ) + Bin/2 ) ) ;  

% compute the b-value uncertainty
Sigma = B/sqrt(N) ; 