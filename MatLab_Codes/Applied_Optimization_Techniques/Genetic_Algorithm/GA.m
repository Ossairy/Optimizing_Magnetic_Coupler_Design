function [Tout] = GA()



Mutation=0.1;                    %%
CrossOver=0.8;                   %%
Elite=0.1;                       %%
NumOfGen =1000;

population = 100;


GenVec =zeros(population,4);  %%  Create new vector the four decision variable are S, Ag ,D and n.  %%
%%% The gen Vector Column is ( S-Slip-    Ag-Air_Gap-    D-Desk_Diameter-    n-Number_of_magnets- )
TqVec =zeros(1,population);



Kdash=(10)^2; %%Assumming that every two magnets generate 1 kg.f when they directly faced to each other with 7mm distance.




%%                                   %% Generate the initial Gens %%                                        %%
i=1;
while(i<=population)
     GenVec(i,2)=(25-5).*rand(1,1)+5;
     GenVec(i,3)=(40-10).*rand(1,1)+10;
     nmax=(1.5*GenVec(i,3))/2;
     GenVec(i,4)=(int16((nmax-2).*rand(1,1)+2))*2;  %% multiplyed by 2 to be always even number
     p=(3.14159*GenVec(i,3))/GenVec(i,4);
     GenVec(i,1)=(p-1).*rand(1,1)+1;


    i=i+1;
end

i=1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                    %% END Initial Condition %%                                           %%


while(NumOfGen>0)











  %% Objective Function:

  while(i<=population)


      S=GenVec(i,1);
      Ag=GenVec(i,2);
      D=GenVec(i,3)*10;
      n=GenVec(i,4);

           
    p=(3.14159*D)/n;

    d1=sqrt(S^2+Ag^2);

    d2=(sqrt((p-S)^2+Ag^2));

    F1dash=Kdash/(d1^2);
    F2dash=Kdash/(d2^2);
    R=D/2;

    F1=F1dash*(S/d1);
    F2=F2dash*((p-S)/d2);
    TqVec(1,i)=n*(F1+F2)*R/100;

      i=i+1;
  end
  i=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Putting the values in assending order to use it later.


ChVec =zeros(1,population);

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
i=1;


%%display(ChVec);
%%display(TqVec);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Choosing Childs :

%%elite choosing:

CldVec=zeros(population,4);

j=(Elite*population);
while(i<=j)
    CldVec(i,:)=GenVec((ChVec(1,i)),:);
    i=i+1;
end
i=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Mutations choosing:Random Resetting

j=Mutation*population;
while(i<=j)
      %%%S=GenVec((ChVec(population-i+1)),1);
      %%%Ag=GenVec((ChVec(population-i+1)),2);
      D=GenVec((ChVec(population-i+1)),3)*10;
      n=GenVec((ChVec(population-i+1)),4);
      nmax=((1.5*D)/2)/10;

           
    p=(3.14159*D)/n;
    
    
    m=randi(4,1);
    CldVec((population-i+1),:)=GenVec((ChVec(population-i+1)),:);
    
    if(m==1)
        p=int16(p);
        CldVec((population-i+1),1)=int16((p-1).*rand(1,1)+1);
    
    elseif m==2
        CldVec((population-i+1),2)=int16((25-5).*rand(1,1)+5);
        

    
    elseif(m==3)
        CldVec((population-i+1),3)=int16((40-10).*rand(1,1)+10);

    
    elseif(m==4)
         CldVec((population-i+1),4)=(int16((nmax-2).*rand(1,1)+2))*2;
    end

    
    i=i+1;
end
%%i=1;


%%%CrossOver :Uniform Crossover


i=(Elite*population)+1;
j=population*(1-Mutation);

while(i<=j)

    Rn=zeros(1,2);

    %%%Generate to differant random numbers
    r=1;

    while(r<=2)
        Rn(1,r)=randi(4,1);
        if(Rn(1,1)==Rn(1,2))
            Rn(1,r)=randi(4,1);
        else
            r=r+1;
        end
       
    end

   
 CldVec(i,:)=GenVec((ChVec(1,i)),:);
 %%CldVec(i,:)=zeros(1,4);

 CldVec(i,Rn(1,1))=GenVec((ChVec(1,1)),Rn(1,1));

 CldVec(i,Rn(1,2))=GenVec((ChVec(1,1)),Rn(1,2));
 %%%every iteration we generate only one child as a result of cross over
 %%%the 1st elite and the pointed parent.








    i=i+1;
end
i=1;
   
 %% GenVec=CldVec;   %%%Update the gene vector with the child vector.
 %% CldVec=zeros(population,4);

%%display(GenVec);
%%display(CldVec);

while(i<=population)

    GenVec(i,:)=CldVec(i,:);

    i=i+1;
end





%%plot(i,10);

    NumOfGen=NumOfGen-1;
end
display(GenVec((ChVec(1,1)),:));
Tout=TqVec(1,(ChVec(1,1)));



end
