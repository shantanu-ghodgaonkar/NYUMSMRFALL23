function dist = distBodyBody(b1, b2)
% b1 and b2 can be: line, polygon, circle

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

switch b1.type
    
%%
   case 'circle'    
       
       switch b2.type
           
           case 'circle'
               dist = distCircleCircle(b1, b2);
           case 'line'
               dist = distCircleLine(b1, b2);
           case 'polygon'
               dist = distCirclePolygon(b1, b2);
           otherwise
               error('Unknown body')
       
       end    
       
%%
   case 'line'
       
       switch b2.type
           
           case 'circle'
               dist = distCircleLine(b2, b1);
           case 'line'
               dist = distLineLine(b1, b2);
           case 'polygon'
               dist = distLinePolygon(b1, b2);
           otherwise
               error('Unknown body')
       
       end  
      
%%
   case 'polygon'
       
       switch b2.type
           
           case 'circle'
               dist = distCirclePolygon(b2, b1);
           case 'line'
               dist = distLinePolygon(b2, b1);
           case 'polygon'
               dist = distPolygonPolygon(b1, b2);
           otherwise
               error('Unknown body')
       
       end  
      
%%
   otherwise
      error('Unknown body')
      
%%

end

