function [D1,D2] = MagDistr( data , columnmag , binarray )

% INPUT :
% cata = catalogue of events
% columnmag = the magnitude column of the catalogue
% binarray = bin of the magnitudes in the catalogue (usually for Mw is 0.01 and for ML is 0.1);

% OUTPUT :
% D1 = non-cumulative number of events
% D2 = cumulative number of events


D1 = histc( data( : , columnmag ) , binarray ) ;

D2primo = cumsum( D1( end : -1 : 1 ) ) ;
D2      = D2primo( end : -1 : 1 ) ;

plot(binarray + 0.05 ,log10(D1),'.r' )
hold on
plot(binarray + 0.05 ,log10(D2),'ob' )

set( gca, 'fontsize' , 14 )

xlabel( 'Magnitude' , 'fontsize' , 14 )
ylabel( 'Log10 Number of Events', 'fontsize' , 14 )
