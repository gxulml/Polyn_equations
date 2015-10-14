function AA = coefmatrix(vn,d)
%   文件名: coefmatrix.m
%   版权: GuangXi Univ.
%   作者: Xz Tang, robo
%   日期: Oct. 12, 2015  
%   描述: 求希尔伯特零点定理的证书（只求出系数矩阵而已）
%   输入变量说明： vn为顶点数
%                 d为最高阶数  

a = vn * (vn-1) /2;                 %计算边数a, a同时也是变量数
x_id_range = [1,a];                 %x变量下标的变化范围 
x = sym('x',x_id_range);            %定义边变量x，它是一组符号变量x(i) ( i = 1,...,a )
n = (a + 1)*(vn * (vn - 1) * (vn - 2) / 6 + a)      %计算系数的个数
c_id_range = [1,n];                 %x变量下标的变化范围 
c = sym('c',c_id_range);            %定义边变量c，它是一组符号变量c(i) ( i = 1,...,n )

syms f                              %定义符号变量
f = r33func(x,d,vn);                 %令f为R(3,3)对应的希尔伯特零点定理恒等式的左边
g = expand(f)                       %展开

%下边的代码求各单项式的系数：
g1 = subs(g,x,zeros(1,a));          %求常数项
gA(1)=g1                            %存到数组中，作为第一项

for i=1:a
    gA(i+1)=coef_one(g, g1, x,a,i,d);   %循环求x(1), x(2), ..., x(a)的系数（是以c为变量的多项式）
end

global power_matrix                 %定义公共变量，求指数矩阵时要用
power_matrix = [];                  %初始化为空
powerline = zeros(1,a);             %定义一个全为0的，具有a个元素的数组
powers(a, d, 1, powerline)          %求阶数为d的所有单项式的指数的矩阵
size(power_matrix,1)
for i = 1: size(power_matrix,1)     %对每一个d阶单项式
    gA(i+a+1)= coef_high(g, g1, x,a,power_matrix(i,:));  %求其系数（是一个以c为变量的多项式）     
end
A = gA.';                           %求转置
A(all(A==0,2),:)=[]                 %删除值为0的行 

shift_col = eye(1,n);               %初始化为[1,0,0,..., ]

for i=1:n                               %循环
    t(:,i) = subs(A,c,shift_col);       %按替换列表c，将A中的多项式的单项式，依次替换成shift_col 
    shift_col = circshift(shift_col,[0,1]) ;  %右移
end

AA = double(t)                          %将t变成矩阵形式
B = eye(size(AA,1),1);                  %第一个元素为1，其他为0 
C = AA\B                                %求系数矩阵

end

