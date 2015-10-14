function [h] = coef_one(g, g1, x,a,k,d)
%   文件名: coef_one.m
%   版权: GuangXi Univ.
%   作者: Xz Tang, robo
%   日期: Oct. 12, 2015  
%   描述: 求x_k的系数
%   输入变量说明： g为给定的多项式
%                 g1为多项式的常数项
%                 x为变量数组，k为欲求系数的x的下标，x(k)即为x_k
%                 a为变量数
%                 d为单项式最高阶数 

%使用subs函数替换，从而求出系数
%被替换项列表为[x(k)^2, x(k)^3,...,x(k)^d, x(1), x(2),...,x(a),常数项]
%该列表中的项将依次被替换为[0,...,0,1,0,...]，1的位置对应上边列表的x(k)的位置

%第一个for循环用于求列表前半段,即x(k)^i那些项(i = 2,...,d)：
for i = 1:d-1
    termarr(i)=x(k)^(i+1);
end

%第二个for循环用于求列表后半段,即x(i)那些项(i = 2,...,a)：
for i=1:a
    termarr(i+d-1)=x(i);
end

termarr(a+d) = g1;                          %设置被替换列表的最后一项为常数项
repval = zeros(1,a+d);                      %定义一个全为0的a+d个元素的数组
repval(d+k-1) = 1;                          %第d+k-1个元素置为1，对应termarr中x(k)的位置
h = subs(g,termarr,repval)                  %按替换列表termarr，将表达式g中的变量，依次替换成repval指定的值
end

