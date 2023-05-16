function [ a,epsilon ] = durvin( r )
r=r(:);
p=length(r)-1;
a=1;
epsilon=r(1);
for j=2:p+1
    gamma=(-r(2:j)'*flipud(a))/epsilon;
    a=[a;0]+gamma*[0;conj(flipud(a))];
    epsilon=epsilon*(1-abs(gamma)^2);
end

