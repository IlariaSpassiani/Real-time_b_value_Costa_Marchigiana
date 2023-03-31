function [ B , N , Sigma ] = Analysis( Cat_Raw , Magn_Compl )

% INPUT :
% Cat_Raw = catalogue of events in ZMAP format
% Magn_Compl = array of completeness magnitudes

% OUTPUT :
% B = b-value Maximum Likelihood Estimation (of the Gutenberg-Richter law) 
%   taking into account the bin of the magnitudes 
% N = total number of events bigger or equal to MC
% Sigma = b-value uncertainty


Center   = [ 13.324 , 44.013 ] ;  % Long and Lat
DistMax  = 30 ;                   % Km
DepthMax = 30 ;                   % Km

% select the events with the previous threshold criteria
Cat = Cat_Raw( Cat_Raw( : , 7 ) <= DepthMax & ...
      distance( Cat_Raw( : , 2 ) , Cat_Raw( : , 1 ) , Center(2) , Center(1) ) ...
      .* pi/180*6371 <= DistMax , : ) ;


% MFD and Num vs Magn plots (all selected events)
figure
subplot( 1 , 2 , 1 )
[D1,D2] = MagDistr( Cat , 6 , 0.55 : 0.1 : 5.75 ) ;
xlim( [ min( Cat(:,6) ) - 0.05 , max( Cat(:,6) ) + 0.05 ] )
ylim( [ -0.05 , max( log10(D2) ) + 0.05 ] ) 
legend( 'Incremental distribution' , 'Cumulative distribution' )

subplot( 1 , 2 , 2 )
plot( Cat( : , 6 ) , '.' )
set( gca, 'fontsize' , 14 )
xlabel( 'Sequential Number' )
ylabel( 'Magnitude' )
box on
xlim( [ -1 , size( Cat , 1 ) + 1 ] ) ;
ylim( [ min( Cat( : , 6 ) ) - 0.05 , max( Cat( : , 6 ) ) + 0.05 ] )

axes( 'Position', [0, 0.95, 1, 0.05] ) ;
set( gca, 'Color', 'None', 'XColor', 'None', 'YColor', 'None' ) ;
text( 0.5, 0, 'With STAI', 'FontSize', 14', 'FontWeight', 'Bold', ...
      'HorizontalAlignment', 'Center', 'VerticalAlignment', 'Bottom' ) ;


%%% remove some events after the initial (strongest) one

% length of the period to remove (in days)
DeltaT = 1/6 ;

% occurrence time since the mainshock (in days)
Time = datenum( Cat( : , [ 3 : 5 , 8 : 10 ]) ) - ...
        datenum( Cat( 1 , [ 3 : 5 , 8 : 10 ]) ) ;

% select events
Cat_NoSTAI = Cat( Time >= DeltaT , : ) ;


% MFD and Num vs Magn plots (events after removal)
figure
subplot( 1 , 2 , 1 )
[D1,D2] = MagDistr( Cat_NoSTAI , 6 , 0.55 : 0.1 : 5.75 ) ;
xlim( [ min( Cat_NoSTAI(:,6) ) - 0.05 , max( Cat_NoSTAI(:,6) ) + 0.05 ] )
ylim( [ -0.05 , max( log10(D2) ) + 0.05 ] )
legend( 'Incremental distribution' , 'Cumulative distribution' )

subplot( 1 , 2 , 2 )
plot( Cat_NoSTAI( : , 6 ) , '.' )
set( gca, 'fontsize' , 14 )
xlabel( 'Sequential Number' )
ylabel( 'Magnitude' )
box on
xlim( [ -1 , size( Cat_NoSTAI , 1 ) + 1 ] ) ;
ylim( [ min( Cat_NoSTAI( : , 6 ) ) - 0.05 , max( Cat_NoSTAI( : , 6 ) ) + 0.05 ] )

axes( 'Position', [0, 0.95, 1, 0.05] ) ;
set( gca, 'Color', 'None', 'XColor', 'None', 'YColor', 'None' ) ;
text( 0.5, 0, 'Without STAI', 'FontSize', 14', 'FontWeight', 'Bold', ...
      'HorizontalAlignment', 'Center', 'VerticalAlignment', 'Bottom' ) ;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% Part 2: estimation of the b-value for some selected magnitude
%%% thresholds

% estimate b-value and sigma (error)s for every completeness threshold
for i = 1 : length( Magn_Compl )
    
    [ B(i) , N(i) , Sigma(i) ] = BvalueEstimation( Cat_NoSTAI , 6 , Magn_Compl(i) , 0.1 ) ;
end