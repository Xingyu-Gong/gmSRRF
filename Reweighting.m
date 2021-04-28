function I = Reweighting(Io, Ivar, Gvar,th)
% reweighting the raw sequence in spatial domain
[Height,Width,Size] = size(Io);
I = zeros(Height,Width,Size);
W = zeros(Height,Width);
maxIvar = max(max(Ivar));
maxGvar = max(max(Gvar));
Ivar = Ivar/maxIvar;
Gvar = Gvar/maxGvar;

% thresholding to ensure convergence in background areas
for i=1:Height
    for j=1:Width
        if Ivar(i,j)>= th
            W(i,j) = Ivar(i,j)./( Gvar(i,j)* ( (Ivar(i,j)-th)/maxIvar )+1);
        else
            W(i,j) = Ivar(i,j) ;
        end
    end
end
W = W/max(max(W));
bias = th / maxIvar;
for s=1:Size
      I(:,:,s) = Io(:,:,s) .* (bias+ W);
end
end

