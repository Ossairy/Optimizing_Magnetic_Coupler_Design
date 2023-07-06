function [BestVec] = FindBest(TqVec,population)



%%population=100;
ChVec =zeros(1,population);
i=1;
while(i<=population)
    c=0;
    j=1;
    while(j<=population)
        if(TqVec(1,i)>TqVec(1,j))
           c=c+1;
        end
        j=j+1;

    end
ChVec(1,(population-c))=i;    
    
    i=i+1;
end


BestVec=ChVec;
end