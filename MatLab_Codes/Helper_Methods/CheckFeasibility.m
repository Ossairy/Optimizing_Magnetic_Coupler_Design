function [f] = CheckFeasibility(GenVec,Position,j)

%%GenVec=[1 1 10 1];
%%Position=2;
%%j=4

if(j==1)
  p=(3.14159*GenVec(1,3))/GenVec(1,4);
    if(Position>p)
        f=0;
    elseif(Position<1)
        f=0;
    else
        f=1;
    end



elseif(j==2)    
    if(Position>25)
        f=0;
    elseif(Position<5)
        f=0;
    else
        f=1;
    end

elseif(j==3)
    if(Position>40)
        f=0;
    elseif(Position<10)
        f=0;
    else
        f=1;
    end

elseif(j==4)
    nmax=2*(1.5*GenVec(1,3))/2;

    if(Position>nmax)
        f=0;
    elseif(Position<2)
        f=0;
    else
        f=1;
    end


end

 

%%f=1;


end