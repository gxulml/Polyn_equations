function fy = r33func(x,d,vn)
%   文件名: r33func.m
%   版权: GuangXi Univ.
%   作者: Xz Tang, robo
%   日期: Oct. 12, 2015  
%   描述: 生成希尔伯特零点定理恒等式左边的多项式
%    
%   输入变量说明： x为边变量，是一组符号变量x(i) ( i = 1,...,n )。x(i)就是论文定义1中的x_i，如x(1)代表第一条边 <1,2>
%                 d为最高阶数
%                 vn为顶点数

en = vn * (vn-1) /2;                %计算边数
e = sym(zeros(vn,vn));              %定义边集对应的二维数组，e(i,j)代表<i,j>所对应的边变量，初始化为0 
k = 1;                              %x变量的起始标号
for i=1:vn                          %对每个顶点 i   
    for j = i+1 : vn                %对每个i的邻点j
        e(i,j) = x(k) ;             %将变量x(k)赋给e(i,j)
        k = k+1;                    %k自增
    end
end
vertex =[];                         %顶点集，初始化为空
for i = 1:vn
    vertex = [vertex,i] ;           %生成顶点集{1,2,3,...,vn}
end

combarr = combntns(vertex,3);        %从顶点集vertex中任选3个顶点，求所有的取值组合
size_of_combarr = size(combarr,1);   %求所有取值组合的总数，即3团的数目
for i = 1:size_of_combarr            %对每一个3团
    u = combarr(i,1);                %令u为第1个顶点
    v = combarr(i,2);                %令v为第2个顶点
    w = combarr(i,3);                %令w为第3个顶点
    h = e(u,v)+e(u,w)+e(v,w);        %令h为3团的3条边的和, 即定义1的S_G(G为3团K_3)
    f(i) = (h-1)*(h-2);              %因为s=t=3，因此定理2最后两个方程合并，得到f(i)
end

for i = 1:en
    f(size_of_combarr+i) = x(i)*(x(i)-1) ;               %对应定理2第一个方程，即f_i
end

cnum = (en + 1)*(vn * (vn - 1) * (vn - 2) / 6 + en)      %计算系数的个数
c = sym('c',[1,cnum]);                                   %系数变量
syms fy                                                  %定义多项式符号变量
fy = 0;

for i = 1:35                                             %6个顶点，15条边，20个3团，因此有（20+15=35）个方程
    k = 16 * (i-1) + 1;                                  %15个变量，每个变量前一个系数，还有一个常数项，共16个
    alpha(i) = c(k);                                     %引言中提到的希尔伯特零点定理的alpha_i，初始化为常数项系数
    for j = 1:15
        alpha(i) = alpha(i) + c(k+j) * x(j);             %逐一加上c_(k+j) * x_j，最后alpha_i = c_k + c_(k+1) * x_1 + c_(k+2) * x_2 + ... + c(k+15) * x_15
    end
    fy = fy + alpha(i) * f(i);                           %逐一加上 alpha_i * f_i
end

end

