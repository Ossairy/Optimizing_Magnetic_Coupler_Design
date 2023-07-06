function [MCPvec] = FeasibleRandom()



     MCPvec(1,2)=((25-5).*rand(1,1))+5;

     MCPvec(1,3)=(40-10).*rand(1,1)+10;

     nmax=(1.5*MCPvec(1,3))/2;

     MCPvec(1,4)=(int16((nmax-2).*rand(1,1)+2))*2;  %% multiplyed by 2 to be always even number
    
     p=(3.14159*MCPvec(1,3))/MCPvec(1,4);

     MCPvec(1,1)=(p-1).*rand(1,1)+1;


%%%MCPvec=0;

end