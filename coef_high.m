function [h] = coef_high(g, g1, x, a, pows)
%   文件名: coef_high.m
%   版权: GuangXi Univ.
%   作者: XZ Tang, robo
%   日期: Oct. 12, 2015  
%   描述: 求单项式t的系数，t由pows指出。
%         如，pows = [1,3,0,2]，则单项式t为x(1) * x(2)^3 * x(4)^2
%   输入变量说明： g为给定的多项式
%                 g1为多项式的常数项
%                 x为变量数组，x(i)即为x_i
%                 a为变量数
%                 pows为t的指数数组


%使用subs函数替换，从而求出系数
%被替换项列表为[t, x(1), x(2),...,x(a),常数项]
%该列表中的项将依次被替换为[1,0,...]

t = 1;                                     %初始化t

%第一个for循环用于求t：
for i = 1:a                                
    t = t * x(i)^(pows(i));    
end
termarr(1) = t;                            %设置被替换列表的第一项为t

%第二个for循环用于设置替换列表的第2项到第a+1项目：
for i=1:a
    termarr(i+1)=x(i);
end

termarr(a+2) = g1;                         %设置被替换列表的最后一项为常数项              
repval = zeros(1,a+2);                     %定义一个全为0的a+2个元素的数组
repval(1) = 1;                             %第一个元素置为1
h = subs(g,termarr,repval)                 %按替换列表termarr，将表达式g中的变量，依次替换成repval指定的值
end

