% Final script
clear all
close all


%%% Part 1: load the ISIDE catalog (need to be converted in ZMAP format!)

Cat_Raw13 = load( 'Cat_13Nov_ZMAP.txt' ) ;

Cat_Raw16 = load( 'Cat_16Nov_ZMAP.txt' ) ;



%%% Part 2: analysis

Magn_Compl = 2.2 : 0.1 : 2.5 ;

[ B13 , N13 , Sigma13 ] = Analysis( Cat_Raw13 , Magn_Compl );

[ B16 , N16 , Sigma16 ] = Analysis( Cat_Raw16 , Magn_Compl );



%%% Part 3: final figure for the b-value
figure 

errorbar( Magn_Compl , B13 , 1.96*Sigma13 , 'LineWidth' , 2.5 )
set( gca, 'fontsize' , 14 )
hold on
errorbar( Magn_Compl+0.002 , B16 , 1.96*Sigma16 , 'LineWidth' , 2.5 )
set( gca, 'fontsize' , 14 )

box on
xlabel( 'Magnitude of completeness' )
ylabel( 'b-value' )
legend( 'b-value with 95% CI 13 Nov', 'b-value with 95% CI 16 Nov' )
xlim( [ Magn_Compl(1) - 0.05 , Magn_Compl(end) + 0.05 ] )

ylim([ 0.5 1.4])

