function mapping=mapping_gray(k) %kaloume gia k=4 (16-PSK)
ph1=[pi/4];
theta=[ph1; -ph1; pi-ph1; -pi+ph1];
mapping=exp(1i*theta);
if(k>2)
 for j=3:k
      theta=theta/2;
      mapping=exp(1i*theta);
      mapping=[mapping; -conj(mapping)]; %simpliromatiko
      %scatterplot(mapping);
      %for j=1:(length(mapping))
         %text(real(mapping(j))-0.1,imag(mapping(j))+0.05,num2str(de2bi(j-1,k,'left-msb')),'FontSize', 7)
      %end
      theta=angle(mapping);
 end
end
%scatterplot(mapping);
%for j=1:(length(mapping))
%   text(real(mapping(j))-0.1,imag(mapping(j))+0.05,num2str(de2bi(j-1,k,'left-msb')),'FontSize', 6);
%end