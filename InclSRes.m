function res = InclSRes(PUI,PRs)

res(1,:) =  PUI(1,:) + PRs*PUI(2,:)*0.032*1e-3;
res(2,:) =  PUI(2,:);